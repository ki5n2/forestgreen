### A Pluto.jl notebook ###
# v0.18.2

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ c7d76e7e-c3bd-4f28-b710-0f3753b854c5
using Plots, Distributions, PlutoUI, Random

# ╔═╡ d85d7710-b49a-11ec-1de6-f5857e0f43ef
md"""# Statistic Computing

topic: Inverse cdf method motive, 지수함수의 무기억성, 몬테카를로 적분, 박스뮬러변환

lecture: Statistic Computing_4-2st

lecture date: 2022-03-29

professor: Guebin Choi

study date: 2022-04-05

author: Kione KIm
"""

# ╔═╡ a2f7d2de-6ae9-4caa-b7dc-fc68954e765d
Plots.plotly()

# ╔═╡ ce838d24-b5cf-4223-a348-f36b3738bd17
md"## 지수분포"

# ╔═╡ 945b7190-46a6-453d-88ea-1f746aeaad7b
md"`-` 지수분포를 뽑는 방법
- 함수 사용
- 포아송프로세스 이용
- Inverse cdf method"

# ╔═╡ 6721f3c4-ffe9-400c-a0c0-a6a85de577b8
md"### Inverse cdf method motive"

# ╔═╡ 2ec38945-36f9-4dad-b855-16b5cec1aca0
md"`-` 평균이 1인 지수분포, 평균이 5인 지수분포를 고려해보자"

# ╔═╡ 154ae7ff-8327-4053-8780-ea4399ac102c
md"`-` cdf"

# ╔═╡ e1a264c9-5b85-4d20-a6e6-78a8a4eeedab
let
	p1=plot(x -> -exp(-x)+1,0,20,title="평균=1")
	p2=plot(x -> -exp(-x/5)+1,0,20,title="평균=5")
	plot(p1,p2,layout=(1,2))
end

# ╔═╡ 5d77017b-090c-4293-a22b-9a1120dcd36d
md"`-` cdf의 y축에서 랜덤변수를 발생시킨 뒤 -> ↓ 이동하여 x축에 내린다고 생각해보자
- 평균=1, 5 이하에서 대부분이 떨어짐
- 평균=5, 5 이하에서 63% 정도만 떨어짐
"

# ╔═╡ 4122cedf-c6b7-459d-936b-a21a32438e26
md"`-` 이를 구현해보자"

# ╔═╡ 2f4b68f7-b9ac-4d7e-821c-5e5a3f88d428
let
	Finv(x)= -log(1-x) # f(x)의 역함수
	Ginv(x)= -5log(1-x) # g(x)의 역함수
	u=rand(5) # 5개의 (유니폼)난수 추출
	p1=plot(x -> -exp(-x)+1,0,20,title="평균=1")
	scatter!([0,0,0,0,0],u)
	scatter!(Finv.(u),[0,0,0,0,0])
	p2=plot(x -> -exp(-x/5)+1,0,20,title="평균=5")
	scatter!([0,0,0,0,0],u)
	scatter!(Ginv.(u),[0,0,0,0,0])
	plot(p1,p2,layout=(1,2))
end

# ╔═╡ b139fc97-6ff2-47af-8c3b-8cd9970fc72b
md"- 주황= 균등분포(u)
- 초록= 지수분포..?!"

# ╔═╡ c176c10f-71e1-4ebe-8f11-b911fbbdd0a5
md"""#### inverse cdf method 알고리즘 정리 

확률변수 $X_1,X_2,\dots,X_n \overset{iid}{\sim} F$ 를 생성 

1.  균등분포에서 $n$개의 난수를 독립적으로 생성한다. 이를 $U_1,U_2, \dots U_n$ 이라고 하자. 
2.  $X_1 = F^{-1}(U_1),X_2=F^{-1}(U_2),\dots, X_n=F^{-1}(U_n)$ 이라고 놓는다. 
"""

# ╔═╡ 6e37439e-1f72-43dd-a1f7-859ebc5ebbcc
md"`-` 예제1: inverse cdf를 이용하여 평균이 1인 지수분포 10000개를 생성해보자"

# ╔═╡ 388dc93a-7c5a-42da-aa1a-73a0d050534d
rand(10000)

# ╔═╡ d27c57ae-6171-42a6-9b7e-457778e49ee1
let
	p1=histogram(rand(10000) .|> x -> -log(1-x))
	p2=histogram(rand(Exponential(1),10000))
	plot(p1,p2,layout=(2,1))
end

# ╔═╡ 6695238e-4cee-4b9a-a2c6-593c2d983050
md"### 지수분포의 무기억성: 과거는 중요하지 않다!
이론: $X \sim Exp(1/\lambda) \Rightarrow$ 모든 $t,s > 0$ 에 대하여 $P(X>t)=P(X>t+s|X>s)$가 성립
"

# ╔═╡ 7a650d7c-e13a-4e8b-84c6-0df0169e634f
md"""
개념: 
- 이해를 위해서 $t=1,s=9$ 대입 => $P(X>1)=P(X>10 | X>9)$
- 좌변: 시간을 1 기다려서 이벤트가 발생하지 않을 확률과 같음 
- 우변: 시간을 9 기다렸는데 이벤트가 발생하지 않았음(조건부) -> 시간을 10 기다려서 이벤트가 발생하지 않을 확률과 같음
- 예를 들어 $\lambda=0.1$ 이라면 (지수분포이기 때문에) 한 번 이벤트 발생하는데 평균적으로 시간 10이 걸린다는 의미 
직관: 
- 좌변: 시간 1을 기다림 
- 우변: 시간 9를 기다렸음 -> 곧 사건이 평균적으로 발생하는 시간(10)에 가까워짐
-> 우변의 확률이 더 크지 않나?!
: NO ! 확률 같음 !
"""

# ╔═╡ 8b05eff7-5f5a-4a4e-8c82-e11d6229c74d
md"""
이해:    

지수분포의 근본: 포아송 프로세스 
- 매우 짧은 시간 
- 매우 작은 확률 
- 매우 많은 베르누이 시행이 독립적으로 수행 -> 지금까지 실패했다고 해서 이후에 성공확률이 높아지는건 아님 
- 우변에서 이미 시간 9동안 무수히 많은 독립적인 베르누이 시행을 놓친상태,
- 그 이후의 시행은 모두 독립이므로 좌변의 확률보다 더 크다고 볼 수 없다
- 즉, 독립이므로 확률이 다르지 않다!
"""

# ╔═╡ d24d13b2-a306-491f-af88-9c1e324635e5
md"#### 시물레이션을 통한 확인"

# ╔═╡ 20fd248e-078f-4630-976f-80021c7a5223
md"t= $@bind t Slider(0.01:0.01:5,show_value=true)"

# ╔═╡ c6cf9c45-e4fb-4ce2-a92f-0214d4b9b76d
md"s= $@bind s Slider(0.01:0.01:5,show_value=true)"

# ╔═╡ f3d4dabc-49eb-4612-a60c-0a0918718c80
let
	N=500000
	X= rand(Exponential(1),N)
	left= length(X[X .> t])/N # length(X[X .> t])/ lengrh(X)
	right= length(X[X .> t+s])/length(X[X .> s])
	md"""
	-  $t=$ $t
	-  $s=$ $s
	-  $P(X>t)=$ $(left)
	-  $P(X>t+s|X>s)=$ $(right)
	"""
end

# ╔═╡ 2a325de2-4c43-400f-85eb-f9dcf6b95209
md"$P(X>1)=P(X>2|X>1)=P(X>3|X>2)=...$"

# ╔═╡ 4ff81682-8f46-4614-83d3-2bb153512a0f
let
	N=50000
	X=rand(Exponential(1),N)
	prob1=length(X[X.>1])/N
	prob2=length(X[X.>2])/length(X[X.>1])
	prob3=length(X[X.>3])/length(X[X.>2])
	prob4=length(X[X.>4])/length(X[X.>3])
	prob5=length(X[X.>5])/length(X[X.>4])
	md"""
	-  $P(X>1)$= $(prob1)
	-  $P(X>2|X>1)$= $(prob2) 
	-  $P(X>3|X>2)$= $(prob3)
	-  $P(X>4|X>3)$= $(prob4)
	-  $P(X>5|X>4)$= $(prob5)
	"""
end

# ╔═╡ 3acecf23-f85f-49fe-86dc-4069a98bd646
md"- 확률이 같은 것을 알 수 있다! 
- 무기억성: 과거는 중요하지 않다!"

# ╔═╡ b5eef642-77b7-4005-9532-73da5ebad7bd
md"### 몬테카를로 적분"

# ╔═╡ bc53a909-c0d9-45ef-a765-94335911f6eb
md"""
`-` 예제1: 아래를 계산하라.

$\int_0^{\infty} x e^{-x}dx =?$
"""

# ╔═╡ 04f44e05-af50-4904-86b8-b88fadbcc5f9
md"""
(손풀이1): 부분적분

$\int_0^\infty x e^{-x}dx =??=1$
"""

# ╔═╡ 14d5c1df-c973-4260-bd1d-759892dbc858
md"""
(손풀이2): 지수분포 이용

$\int_0^\infty x e^{-x}dx =\int_0^\infty x \times e^{-x}dx$
: $e^{-x}$은 평균이 1인 지수분포의 pdf이고 $x$ x pdf = 평균이기 때문에 $\lambda=1$인 지수분포의 평균(평균이 1인 지수분포의 평균)이 된다! 따라서 답은 1!

- 이는 아래와 같이 풀 수 있다.
"""

# ╔═╡ f292be10-5e5c-45f3-9f0b-6c70298230a8
md"(컴퓨터를 이용한 풀이)"

# ╔═╡ 9f649f08-c8a2-4c6f-8353-3fccc997075a
rand(Exponential(1),10000) |> mean

# ╔═╡ cd76735b-c59c-4925-9295-b7a2dbd9e0dc
md"""
- 평균이 1인 지수분포의 평균
-  $e^{-x}$ 앞에 다른 식이 와도 같은 노테이션이 가능할까?"""

# ╔═╡ a6dfbc15-a2b4-47d6-8280-ac190f0781a7
md"`-` 예제2: 아래를 계산하라.

$\int_0^{\infty} x^2 e^{-x}dx=?$
"

# ╔═╡ 982d45f4-1ab4-40a7-b080-a6bf50b0588b
md"""$\int_0^{\infty} x^2 e^{-x}dx=?$ 
-  $x^2$ × 평균이 1인 지수분포의 pdf
-  평균이 1인 지수분포에서 $x$를 추출하고 이를 제곱한 후 평균을 구해주면 됨
"""

# ╔═╡ e3dba70c-b8e6-4a96-9a69-cdbf5fde006d
md"(컴퓨터를 이용한 풀이)"

# ╔═╡ 90546c78-3b3e-4afa-bf6f-9099f6a2077a
rand(Exponential(1),10000) .|> (x -> x^2) |> mean

# ╔═╡ 6af136de-34be-4f30-b082-fc323345f3d4
md"""- 분산 = 제곱의 평균 - 평균의 제곱 => 제곱의 평균 = 분산 + 평균의 제곱
- 평균= 1 -> 분산 =1 , 평균의 제곱 = 1 => 1+1=2
- 같은 풀이 가능!"""

# ╔═╡ e01607c9-4ed4-477a-b997-baad39f1f29c
md"
$\int_0^{\infty} 2x^3 e^{-x}dx=?$
"

# ╔═╡ 32f1bdb9-c620-40f0-9203-a5e7e0e0625d
rand(Exponential(1),10000) .|> (x -> 2x^3) |> mean

# ╔═╡ cb740b40-dbbd-4b40-8285-c4bbe041fad8
md"""`-` 예제3: 아래를 계산하라

$\int_0^1 e^{-x} dx=?$
"""

# ╔═╡ 1bfd0cfb-51f6-4d18-be23-d09e582d680f
md"(컴퓨터를 이용한 풀이)"

# ╔═╡ 240f237a-e438-4c6e-b8fe-5f8963b7a061
md"""
-  $\int_0^1 e^{-x} dx$은 $\int_0^{\infty} I(x \leq 1)e^{-x}dx$와 같이 표현할 수 있고
- 이는 $\int_0^{\infty} I(x \leq 1)e^{-x}dx=E(I(X\leq 1)),~ X\sim Exp(1)$ 와 같이 정리할 수 있다.
- 단, $I(x \in A )= \begin{cases} 1 & x\in A \\ 0 & o.w \end{cases}$
"""

# ╔═╡ 2cb9a28c-1512-44c8-bb12-376867ec7696
let
	X= rand(Exponential(1),10000)
	f= x -> (x<=1)
	X .|> f |> mean
end

# ╔═╡ e893a671-b0c7-4d96-8bc7-104322691986
md"f는 x가 1보다 ≤ 인지 아니면 ＞ 인지 확인해주는 ($I$)인디케이션 함수임"

# ╔═╡ a98e085e-9daf-46ac-b449-ad7a51e2f5b4
md"(컴퓨터를 이용한 풀이2)"

# ╔═╡ e26b1fa9-8df7-4931-82e9-2da0378da9a8
md"""
$\int_0^1 e^{-x} dx$은 $E(I(X\leq 1))=P(X\leq 1),~ X\sim Exp(1)$ 로 해석 가능하므로 
"""

# ╔═╡ 5ba3eed3-9e57-44ef-b49d-535b5b746285
let
	N=10000
	X=rand(Exponential(1),N)
	length(X[X.<=1])/N
end

# ╔═╡ 2f52d252-54c3-446b-8aa0-ad5064351d7f
md"(컴퓨터를 이용한 풀이3)"

# ╔═╡ 1d4aafe7-714e-490e-8958-69421d1da9b6
md"""$\int_0^1 e^{-x} dx=\int_0^1 e^{-x}\times 1 dx=E(e^{-X}), ~ X\sim U(0,1)$ 로 해석 가능 -> $1$은 위의 적분구간에 한정하여 균등분포에서 뽑은 pdf라 할 수 있다. 따라서 $e^{-x}$ x $1$은 $1$에 $e^{-x}$를 곱한 것의 평균이 된다.
- 균등분포에서 $x$를 뽑은 후 $e^{-x}$를 취해준 것의 평균"""

# ╔═╡ 2dbedeeb-e186-4056-9c43-466c7cd24b80
let
	N=10000
	X=rand(N)
	exp.(-X) |> mean
end

# ╔═╡ 2f6ffedb-fe0e-4344-9402-82b3b148c285
md"""
`-` 참고로 세번째 풀이를 응용하면 아래와 같이 적분구간이 유한한 경우에는 쉽게 그 값을 계산할 수 있다. 
"""

# ╔═╡ 8dc231aa-06b8-4d5a-8672-9d0b43ff3dee
md"""`-` 예제4: 아래를 계산하라

$\int_0^{\pi}\sin(x)dx=\int_0^{\pi}\sin(x)\pi \times \frac{1}{\pi}dx=E(\sin(X)\pi),~ X \sim U(0,\pi)$
"""

# ╔═╡ c9d95cb7-50b7-43d5-8efd-b233933de275
md"`-` 0~π까지의 랜덤샘플 추출"

# ╔═╡ 79ff8d73-2057-45dc-83e1-6957ec59e37a
rand(10000) * π

# ╔═╡ bd51ee0b-3e0c-4b72-a684-9a5689a19899
md"`-` 평균"

# ╔═╡ fe16a59e-2da5-43bf-9079-b0b16b013011
mean(rand(10000)*π .|> x -> sin(x)*π)

# ╔═╡ e7003744-669c-4f9f-a005-997b060b0e7e
md"sin를 적분 -> - cos[π,0] -> -cos(π) + cos(o)"

# ╔═╡ ad294d4d-df1f-4f9c-86f9-60a16e9bc9e2
-cos(π)+cos(0)

# ╔═╡ 6764c537-7704-4726-bd5a-2aeaec67b3ed
md"""`-` 예제5: 아래를 계산하라

$\int_0^{2\pi}\sin(x)dx=\int_0^{2\pi}\sin(x)2\pi \times \frac{1}{2\pi}dx=E(\sin(X)2\pi),~ X \sim U(0,2\pi)$
"""

# ╔═╡ b097cdfb-2653-4346-99b2-65a138cbfc0c
rand(100000) * 2π # U(0,2π)

# ╔═╡ 4db94723-cfed-48a8-aa70-4ab2e91415a0
rand(100000) * 2π .|> x -> sin(x)*2π

# ╔═╡ 673feed3-f3c0-4f10-91fd-dc0c56bc379e
mean(rand(100000) * 2π .|> x -> sin(x)*2π)

# ╔═╡ c03868cd-3f01-460e-a952-6351b9d2798c
md"### 박스뮬러변환"

# ╔═╡ 987c0e88-6a8f-4b0f-b187-c60d7a197117
md"""
이론: $\begin{cases} R^2/2 \sim Exp(1) \\ \Theta \sim U(0,2\pi) \end{cases} \Rightarrow \begin{bmatrix} R\cos \Theta \\ R \sin \Theta \end{bmatrix} \sim N\left (\begin{bmatrix} 0 \\ 0 \end{bmatrix}, \begin{bmatrix} 1 & 0 \\ 0 & 1 \end{bmatrix}\right)$ 
"""

# ╔═╡ 25cfafa5-e6e1-462e-88a7-938fadfa6fd3
@bind i Slider(1:5000)

# ╔═╡ 0405f57e-9720-451c-938b-a96bad06e236
let 
	Random.seed!(50000)
	X=randn(5000)
	Y=randn(5000)
	plot(X,Y,seriestype=:scatter,alpha=0.1)
	plot!([0,X[i]],[0,Y[i]])
end

# ╔═╡ 2adaee3e-16dc-4808-897d-218a901e9268
md"의미: 
- 반지름을 제곱해서 2로 나누면 평균이 1인 지수분포를 따른다
- θ(각도)는 점들이 1,2,3,4분면에 랜덤하게 퍼져있으니 U(0,2π)에서 랜덤하게 뽑힌다.."

# ╔═╡ 2ea6a54c-ee1e-4b1b-99bc-5dee12fd07cc
md"`-` $r^2/2$가 평균이 1인 지수분포를 따르는지 확인해보자"

# ╔═╡ 59e9b5f6-d134-4ef3-91bf-4074fe8aa1ec
let
	N=5000
	X=rand(Normal(0,1),N)
	Y=rand(Normal(0,1),N)
	p1=(X.^2 + Y.^2)./2 |> histogram # 반지름^2/2
	p2=rand(Exponential(1),N) |> histogram
	plot(p1,p2,layout=(2,1))
end

# ╔═╡ d4c36aa6-2473-4218-af78-63daf7c02f6b
md"-  $r^2/2$은 평균이 1인 지수분포를 따르는 것으로 보인다"

# ╔═╡ 199144da-05e9-4bb7-b8e9-de620a848cf7
md"`-` 이를 응용한 정규분포 생성"

# ╔═╡ a7b06a80-798d-4535-9a0b-b33a151a4e4b
let 
	N= 10000000
	R = .√(2*rand(Exponential(1),N))  
	Θ = rand(N).*2π
	T = (R,Θ) -> (R*cos(Θ), R*sin(Θ))
	XY = T.(R,Θ) 
	X = [XY[i][1] for i in 1:N]
	Y = [XY[i][2] for i in 1:N]
	#scatter(X,Y)
	p1=histogram(X)
	p2=randn(N) |> histogram
	plot(p1,p2,layout=(2,1))
end 

# ╔═╡ 2e064c92-d982-4745-b731-9dc5badb8fc1
md"
-  $r^2/2$ = $rand(Exponential(1),N)$
->  $r^2$ = $2*rand(Exponential(1),N)$

->  $r$ = $√*2*rand(Exponential(1),N)$
-  $θ$ ~ $U(0,2π)$
- T는 함수
- XY는 함수가 적용된 저장된 값
"

# ╔═╡ cd67bb63-5779-48e2-b530-a61b377a8cab
md"""
`-` inverse cdf 기법과 합치면 아래와 같이 정리가능하다. 

$\begin{cases}
X=\sqrt{-2\log(1-U_1)} \cos(2\pi U_2) \\ 
Y=\sqrt{-2\log(1-U_1)} \sin(2\pi U_2) 
\end{cases},~ U_1,U_2 \overset{iid}{\sim} U(0,1)$
"""

# ╔═╡ 804f9743-9cab-4d75-bf72-3d1681bddc0f
md"""
-   $- log(1-U_1)$은 앞서 평균이 1인 지수분포의 역함수 `Finv(x)= -log(1-x)`와 같은 꼴이다. 이는 $R$를 구할 때 rand(Exponential(1),N)의 기능을 한다. 
-   $2π*U_2$는 U($0,2π$)이다.
"""

# ╔═╡ 2674e9e3-9384-4b02-923d-e59ed41432c8
let 
	N=10000000
	U₁ = rand(N)
	U₂ = rand(N)
	X = @. √(-2log(1-U₁))*cos(2π*U₂)
	Y = @. √(-2log(1-U₁))*sin(2π*U₂)
	p1 = histogram(X,title="p1") 
	p2 = histogram(randn(N),title="p2")
	p3 = histogram(Y, title="p3")
	p4 = histogram(randn(N),title="p4")
	plot(p1,p2,p3,p4,layout=(2,2))
end

# ╔═╡ 669853f8-f86e-4514-90b6-48ce289d1c0d
md""" ### $λ$에 따른 포아송과 지수분포의 히스토그램 변화
"""

# ╔═╡ 737d50f4-27a4-4ea4-a96f-2b770a9b8d25
lambda = @bind λ Slider(0.1:0.01:10,show_value=true)

# ╔═╡ 4d28e28d-af93-4de0-9766-592441df899d
lambda

# ╔═╡ 2308101b-b0f1-4419-8ade-b5dd123aeeb2
md"- lambda를 위의 방식처럼 받아줄 수 있다. 숫자는 연동되지 않네,,"

# ╔═╡ decc5f46-becb-4c10-91f1-491d8ac5a6ff
let
	p1=histogram(rand(Poisson(λ),10000),title="포아송, λ=$λ")
	p2=histogram(rand(Exponential(1/λ),10000),title="지수분포, λ=$λ")
	plot(p1,p2,layout=(2,1))
end

# ╔═╡ 72ceb4c3-24f7-401d-ae59-56facfc7c209
md"""- λ의 변화에 따라 포아송 분포는 많이 달라짐 특히 λ가 커질수록 분포의 형태가 대칭에 가까워지는 것으로 보임!
- 반면, 지수분포의 형태 자체는 거의 비슷함"""

# ╔═╡ bfb384b1-e6ac-406a-9266-cf7cedb92bbc
md"""#### 추가학습
(1) inverse cdf를 이용하여 평균이 1인 지수분포를 발생

(2) 서로독립인 2개의 정규분포를 이용하여 평균이 1인 지수분포를 발생

(3) 위의 2개의 히스토그램을 비교"""

# ╔═╡ 1fe1b831-e3e5-4b00-9401-635e59cb1837
let 
	N=5000
	p1= histogram(rand(N) .|> x -> -log(1-x))
	X = rand(Normal(0,1),N)
	Y = rand(Normal(0,1),N)
	p2= (X.^2 + Y.^2)./2 |> histogram
	plot(p1,p2,layout=(2,1))
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[compat]
Distributions = "~0.25.53"
Plots = "~1.27.4"
PlutoUI = "~0.7.38"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.2"
manifest_format = "2.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "af92965fb30777147966f58acb05da51c5616b5f"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "9950387274246d08af38f6eef8cb5480862a435f"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.14.0"

[[deps.ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "bf98fa45a0a4cee295de98d4c1462be26345b9a1"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.2"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "Colors", "FixedPointNumbers", "Random"]
git-tree-sha1 = "12fc73e5e0af68ad3137b886e3f7c1eacfca2640"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.17.1"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[deps.Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "96b0bc6c52df76506efc8a441c6cf1adcb1babc4"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.42.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Contour]]
deps = ["StaticArrays"]
git-tree-sha1 = "9f02045d934dc030edad45944ea80dbd1f0ebea7"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.5.7"

[[deps.DataAPI]]
git-tree-sha1 = "cc70b17275652eb47bc9e5f81635981f13cea5c8"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.9.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3daef5523dd2e769dad2365274f760ff5f282c7d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.11"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.DensityInterface]]
deps = ["InverseFunctions", "Test"]
git-tree-sha1 = "80c3e8639e3353e5d2912fb3a1916b8455e2494b"
uuid = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
version = "0.4.0"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Distributions]]
deps = ["ChainRulesCore", "DensityInterface", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SparseArrays", "SpecialFunctions", "Statistics", "StatsBase", "StatsFuns", "Test"]
git-tree-sha1 = "5a4168170ede913a2cd679e53c2123cb4b889795"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.53"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "b19534d1895d702889b219c382a6e18010797f0b"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.6"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.DualNumbers]]
deps = ["Calculus", "NaNMath", "SpecialFunctions"]
git-tree-sha1 = "5837a837389fccf076445fce071c8ddaea35a566"
uuid = "fa6b7ba4-c1ee-5f82-b5fc-ecf0adba8f74"
version = "0.6.8"

[[deps.EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3f3a2501fa7236e9b911e0f7a588c657e822bb6d"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.2.3+0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bad72f730e9e91c08d9427d5e8db95478a3c323d"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.8+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "Pkg", "Zlib_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "d8a578692e3077ac998b50c0217dfd67f21d1e5f"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.0+0"

[[deps.FillArrays]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "Statistics"]
git-tree-sha1 = "246621d23d1f43e3b9c368bf3b72b2331a27c286"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "0.13.2"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "51d2dfe8e590fbd74e7a842cf6d13d8a2f45dc01"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.6+0"

[[deps.GR]]
deps = ["Base64", "DelimitedFiles", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Printf", "Random", "RelocatableFolders", "Serialization", "Sockets", "Test", "UUIDs"]
git-tree-sha1 = "af237c08bda486b74318c8070adb96efa6952530"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.64.2"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Pkg", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "cd6efcf9dc746b06709df14e462f0a3fe0786b1e"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.64.2+0"

[[deps.GeometryBasics]]
deps = ["EarCut_jll", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "83ea630384a13fc4f002b77690bc0afeb4255ac9"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.2"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "a32d672ac2c967f3deb8a81d828afc739c838a06"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.68.3+2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "0fa77022fe4b511826b39c894c90daf5fce3334a"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.17"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.HypergeometricFunctions]]
deps = ["DualNumbers", "LinearAlgebra", "SpecialFunctions", "Test"]
git-tree-sha1 = "65e4589030ef3c44d3b90bdc5aac462b4bb05567"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.8"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.IniFile]]
git-tree-sha1 = "f550e6e32074c939295eb5ea6de31849ac2c9625"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.1"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "91b5dcf362c5add98049e6c29ee756910b03051d"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.3"

[[deps.IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[deps.IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b53380851c6e6664204efb2e62cd24fa5c47e4ba"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.2+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "Printf", "Requires"]
git-tree-sha1 = "6f14549f7760d84b2db7a9b10b88cd3cc3025730"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.14"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "7739f837d6447403596a75d19ed01fd08d6f56bf"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.3.0+3"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "42b62845d70a619f063a7da093d995ec8e15e778"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+1"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "c9551dd26e31ab17b86cbd00c2ede019c08758eb"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.3.0+1"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "58f25e56b706f95125dcb796f39e1fb01d913a71"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.10"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "3d3e902b31198a27340d0bf00d6ac452866021cf"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.9"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "Random", "Sockets"]
git-tree-sha1 = "1c38e51c3d08ef2278062ebceade0e46cefc96fe"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.0.3"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Measures]]
git-tree-sha1 = "e498ddeee6f9fdb4551ce855a46f54dbd900245f"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.1"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NaNMath]]
git-tree-sha1 = "737a5957f387b17e74d4ad2f440eb330b39a62c5"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.0"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ab05aa4cc89736e95915b01e7279e61b1bfe33b8"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.14+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.PCRE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b2a7af664e098055a7529ad1a900ded962bca488"
uuid = "2f80f16e-611a-54ab-bc61-aa92de5b98fc"
version = "8.44.0+0"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "e8185b83b9fc56eb6456200e873ce598ebc7f262"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.7"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "621f4f3b4977325b9128d5fae7a8b4829a0c2222"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.4"

[[deps.Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Requires", "Statistics"]
git-tree-sha1 = "a3a964ce9dc7898193536002a6dd892b1b5a6f1d"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "2.0.1"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "bb16469fd5224100e422f0b027d26c5a25de1200"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.2.0"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "GeometryBasics", "JSON", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "edec0846433f1c1941032385588fd57380b62b59"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.27.4"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "670e559e5c8e191ded66fa9ea89c97f10376bb4c"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.38"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "d3538e7f8a790dc8903519090857ef8e1283eecd"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.5"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "ad368663a5e20dbb8d6dc2fddeefe4dae0781ae8"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+0"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "78aadffb3efd2155af139781b8a8df1ef279ea39"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.4.2"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
git-tree-sha1 = "6bf3f380ff52ce0832ddd3a2a7b9538ed1bcca7d"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.2.1"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase"]
git-tree-sha1 = "dc1e451e15d90347a7decc4221842a022b011714"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.5.2"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "cdbd3b1338c72ce29d9584fdbe9e9b70eeb5adca"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "0.1.3"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "bf3188feca147ce108c76ad82c2792c57abe7b1f"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.7.0"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "68db32dff12bb6127bac73c209881191bf0efbb7"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.3.0+0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "0b4b7f1393cff97c33891da2a0bf69c6ed241fda"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "5ba658aeecaaf96923dce0da9e703bd1fe7666f9"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.1.4"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "4f6ec5d99a28e1a749559ef7dd518663c5eca3d5"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.4.3"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "c3d8ba7f3fa0625b062b82853a7d5229cb728b6b"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.2.1"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "8977b17906b0a1cc74ab2e3a05faa16cf08a8291"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.16"

[[deps.StatsFuns]]
deps = ["ChainRulesCore", "HypergeometricFunctions", "InverseFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "72e6abd6fc9ef0fa62a159713c83b7637a14b2b8"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "0.9.17"

[[deps.StructArrays]]
deps = ["Adapt", "DataAPI", "StaticArrays", "Tables"]
git-tree-sha1 = "57617b34fa34f91d536eb265df67c2d4519b8b98"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.5"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "5ce79ce186cc678bbb5c5681ca3379d1ddae11a1"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.7.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unzip]]
git-tree-sha1 = "34db80951901073501137bdbc3d5a8e7bbd06670"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.1.2"

[[deps.Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "3e61f0b86f90dacb0bc0e73a0c5a83f6a8636e23"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.19.0+0"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4528479aa01ee1b3b4cd0e6faef0e04cf16466da"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.25.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "1acf5bdf07aa0907e0a37d3718bb88d4b687b74a"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.12+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e45044cd873ded54b6a5bac0eb5c971392cf1927"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.2+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "ece2350174195bb31de1a63bea3a41ae1aa593b6"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "0.9.1+5"
"""

# ╔═╡ Cell order:
# ╟─d85d7710-b49a-11ec-1de6-f5857e0f43ef
# ╠═c7d76e7e-c3bd-4f28-b710-0f3753b854c5
# ╠═a2f7d2de-6ae9-4caa-b7dc-fc68954e765d
# ╟─ce838d24-b5cf-4223-a348-f36b3738bd17
# ╟─945b7190-46a6-453d-88ea-1f746aeaad7b
# ╟─6721f3c4-ffe9-400c-a0c0-a6a85de577b8
# ╟─2ec38945-36f9-4dad-b855-16b5cec1aca0
# ╟─154ae7ff-8327-4053-8780-ea4399ac102c
# ╠═e1a264c9-5b85-4d20-a6e6-78a8a4eeedab
# ╟─5d77017b-090c-4293-a22b-9a1120dcd36d
# ╟─4122cedf-c6b7-459d-936b-a21a32438e26
# ╠═2f4b68f7-b9ac-4d7e-821c-5e5a3f88d428
# ╟─b139fc97-6ff2-47af-8c3b-8cd9970fc72b
# ╟─c176c10f-71e1-4ebe-8f11-b911fbbdd0a5
# ╟─6e37439e-1f72-43dd-a1f7-859ebc5ebbcc
# ╠═388dc93a-7c5a-42da-aa1a-73a0d050534d
# ╠═d27c57ae-6171-42a6-9b7e-457778e49ee1
# ╟─6695238e-4cee-4b9a-a2c6-593c2d983050
# ╟─7a650d7c-e13a-4e8b-84c6-0df0169e634f
# ╟─8b05eff7-5f5a-4a4e-8c82-e11d6229c74d
# ╟─d24d13b2-a306-491f-af88-9c1e324635e5
# ╟─20fd248e-078f-4630-976f-80021c7a5223
# ╟─c6cf9c45-e4fb-4ce2-a92f-0214d4b9b76d
# ╟─f3d4dabc-49eb-4612-a60c-0a0918718c80
# ╟─2a325de2-4c43-400f-85eb-f9dcf6b95209
# ╟─4ff81682-8f46-4614-83d3-2bb153512a0f
# ╟─3acecf23-f85f-49fe-86dc-4069a98bd646
# ╟─b5eef642-77b7-4005-9532-73da5ebad7bd
# ╟─bc53a909-c0d9-45ef-a765-94335911f6eb
# ╟─04f44e05-af50-4904-86b8-b88fadbcc5f9
# ╟─14d5c1df-c973-4260-bd1d-759892dbc858
# ╟─f292be10-5e5c-45f3-9f0b-6c70298230a8
# ╠═9f649f08-c8a2-4c6f-8353-3fccc997075a
# ╟─cd76735b-c59c-4925-9295-b7a2dbd9e0dc
# ╟─a6dfbc15-a2b4-47d6-8280-ac190f0781a7
# ╟─982d45f4-1ab4-40a7-b080-a6bf50b0588b
# ╟─e3dba70c-b8e6-4a96-9a69-cdbf5fde006d
# ╠═90546c78-3b3e-4afa-bf6f-9099f6a2077a
# ╟─6af136de-34be-4f30-b082-fc323345f3d4
# ╟─e01607c9-4ed4-477a-b997-baad39f1f29c
# ╠═32f1bdb9-c620-40f0-9203-a5e7e0e0625d
# ╟─cb740b40-dbbd-4b40-8285-c4bbe041fad8
# ╟─1bfd0cfb-51f6-4d18-be23-d09e582d680f
# ╟─240f237a-e438-4c6e-b8fe-5f8963b7a061
# ╠═2cb9a28c-1512-44c8-bb12-376867ec7696
# ╟─e893a671-b0c7-4d96-8bc7-104322691986
# ╟─a98e085e-9daf-46ac-b449-ad7a51e2f5b4
# ╟─e26b1fa9-8df7-4931-82e9-2da0378da9a8
# ╠═5ba3eed3-9e57-44ef-b49d-535b5b746285
# ╟─2f52d252-54c3-446b-8aa0-ad5064351d7f
# ╟─1d4aafe7-714e-490e-8958-69421d1da9b6
# ╠═2dbedeeb-e186-4056-9c43-466c7cd24b80
# ╟─2f6ffedb-fe0e-4344-9402-82b3b148c285
# ╟─8dc231aa-06b8-4d5a-8672-9d0b43ff3dee
# ╟─c9d95cb7-50b7-43d5-8efd-b233933de275
# ╠═79ff8d73-2057-45dc-83e1-6957ec59e37a
# ╟─bd51ee0b-3e0c-4b72-a684-9a5689a19899
# ╠═fe16a59e-2da5-43bf-9079-b0b16b013011
# ╟─e7003744-669c-4f9f-a005-997b060b0e7e
# ╠═ad294d4d-df1f-4f9c-86f9-60a16e9bc9e2
# ╟─6764c537-7704-4726-bd5a-2aeaec67b3ed
# ╠═b097cdfb-2653-4346-99b2-65a138cbfc0c
# ╠═4db94723-cfed-48a8-aa70-4ab2e91415a0
# ╠═673feed3-f3c0-4f10-91fd-dc0c56bc379e
# ╟─c03868cd-3f01-460e-a952-6351b9d2798c
# ╟─987c0e88-6a8f-4b0f-b187-c60d7a197117
# ╠═25cfafa5-e6e1-462e-88a7-938fadfa6fd3
# ╠═0405f57e-9720-451c-938b-a96bad06e236
# ╟─2adaee3e-16dc-4808-897d-218a901e9268
# ╟─2ea6a54c-ee1e-4b1b-99bc-5dee12fd07cc
# ╠═59e9b5f6-d134-4ef3-91bf-4074fe8aa1ec
# ╟─d4c36aa6-2473-4218-af78-63daf7c02f6b
# ╟─199144da-05e9-4bb7-b8e9-de620a848cf7
# ╠═a7b06a80-798d-4535-9a0b-b33a151a4e4b
# ╟─2e064c92-d982-4745-b731-9dc5badb8fc1
# ╟─cd67bb63-5779-48e2-b530-a61b377a8cab
# ╟─804f9743-9cab-4d75-bf72-3d1681bddc0f
# ╠═2674e9e3-9384-4b02-923d-e59ed41432c8
# ╟─669853f8-f86e-4514-90b6-48ce289d1c0d
# ╠═737d50f4-27a4-4ea4-a96f-2b770a9b8d25
# ╠═4d28e28d-af93-4de0-9766-592441df899d
# ╟─2308101b-b0f1-4419-8ade-b5dd123aeeb2
# ╠═decc5f46-becb-4c10-91f1-491d8ac5a6ff
# ╟─72ceb4c3-24f7-401d-ae59-56facfc7c209
# ╟─bfb384b1-e6ac-406a-9266-cf7cedb92bbc
# ╠═1fe1b831-e3e5-4b00-9401-635e59cb1837
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
