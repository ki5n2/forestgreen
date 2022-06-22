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

# ╔═╡ 47c6f7d5-9733-42fd-a758-c9acefc8510a
using Plots

# ╔═╡ 1db3e688-6da6-45a9-81f8-c5c0b24a9782
using PlutoUI 

# ╔═╡ 70c27370-a8ed-11ec-318c-0783c2f81ddd
md"# Statistic Computing

topic: 추가학습 풀이, 함수고급

lecture: Statistic Computing_3-1st

lecture date: 2022-03-17

professor: Guebin Choi

study date: 2022-03-22

author: Kione KIm
"

# ╔═╡ 585fa6ff-bc27-4fca-905f-73142cd53ca0
md"### 추가학습 풀이"

# ╔═╡ 810d60a7-cf24-4158-8bc7-aa5bdd2c9466
md"---"

# ╔═╡ 869d2686-e0d9-4986-b392-61f665260e21
md"##### 예비학습"

# ╔═╡ bb9782aa-1c02-4bd3-a9b9-389271a0ed90
md"- 중복선언은 허용되지 않는다"

# ╔═╡ 6ad29743-7bf7-4a40-8e97-037318a178e7
z=0

# ╔═╡ ea96c5bb-578e-40aa-ba7f-9fc9bf8e8a20
md"`-` 이미 선언한 변수(z)를 함수 내에서 다시 사용할 수 있을까"

# ╔═╡ d51e351c-d49e-4694-8033-72b7904cb0e7
function f(z)
	return z+100
end

# ╔═╡ 200bff16-e4ca-4a0b-9c04-38817dcc241f
md"- 가능하다. 왜냐하면 함수 내에서 선언한 변수(z)는 함수 안에서만 효력이 있기 때문이다"

# ╔═╡ 3022fb9b-295d-4704-9dea-7ce8d6976a95
f(3)

# ╔═╡ 91c00507-008c-47f2-8a57-10597bded7ef
z

# ╔═╡ d98ab2cf-c309-46fd-b00d-bd0c54de7801
md"- f(3)은 z에 3을 입력한 것인데, z값을 다시 보니 여전히 0이다. 즉 함수 안에서 선언한 변수는 외부에 영향을 미치지 않는다."

# ╔═╡ 790a77a9-b588-4943-b593-b38007a55988
md"---"

# ╔═╡ 04b42ea9-2ac6-48c1-8101-5d3588379f3c
Plots.plotly

# ╔═╡ afb88fbb-cf0c-4000-b282-3ed902cd05ab
md"`-` 함수 $f(x)=(x-1)^2$를 함성함수를 이용하여 선언하고 $(x,f(x))$의 그래프를 $x \in (-1,3)$의 범위에서 그린뒤에 제출 (단, x는 -1에서 시작하여 3으로 0.05간격의 벡터를 이용하여 생성한뒤에 그릴것)"

# ╔═╡ 4a10b8a7-3433-4fbc-b749-738ef27088d2
md"##### 풀이 1: 컴프레이션을 활용한 풀이"

# ╔═╡ 5c196190-f3a2-475e-b218-df66c6e162d6
g= (x -> x^2) ∘ (x -> x-1)

# ╔═╡ b4ad0cf3-fa03-43de-a5e5-e0a12bd0d926
x=-1:0.05:3

# ╔═╡ b2e5b4fe-5829-4f73-b318-1e787ff525d6
y2=g(x)

# ╔═╡ d1b4fc80-6344-4719-9b72-442ea651dce0
g(0)

# ╔═╡ 6543455e-d8cf-4ac8-823d-5c700ee8eefb
g(1)

# ╔═╡ 19d99419-f77c-43de-b8a0-55753267d9dc
md"- 오류가 난다. 이유는 g가 스칼라가 출력이 되어야하는 구조이기 때문. g(1), g(0) 등을 출력된다"

# ╔═╡ 5311d732-273c-4a15-b4a4-5af1b22371a8
md"`-` 각각은 계산이 가능하기 때문에 이를 컴프레이션을 활용하여 다음과 같이 구할 수 있다"

# ╔═╡ 4cd85a87-f1ae-4c3c-85c9-dcac78de5e0f
y=[g(x) for x in -1:0.05:3]

# ╔═╡ 4493a6d3-e6a0-45c9-b57d-1cb15e6f3df0
plot(x,y)

# ╔═╡ 274a7733-21f8-4cba-90c6-8e5b2e2b7852
md"##### 풀이 2: 브로드캐스팅을 활용한 풀이"

# ╔═╡ 5e964ff6-a017-43e7-86bd-94e1e99a1339
md"`-` x를 g에 적용하면 x의 모든 값에 대하여 함수를 적용하여 계산되지 않을까? 즉, x를 g에 적용하면 브로드 캐스팅이 일어나 계산이 되지 않을까?"

# ╔═╡ 722d1f4f-c465-4d72-9c1f-2e40d208f95a
x

# ╔═╡ eb5cad66-1712-49f3-8efe-16d120cc3264
plot(x,g(x))

# ╔═╡ ae037d9a-fa76-44ce-b0a8-e358edfb07cf
md"- 오류가 남. 이는 앞서 본 것과 같이 g는 스칼라가 출력되어야 하는데, x는 스칼라가 아닌 벡터이기 때문에 나는 오류이다"

# ╔═╡ c03800cf-41b8-4ce4-b914-6c60c3cfabe6
md"`-` 함수의 경우 브로드캐스팅을 적용할 때 함수 뒤에 `.`을 입력해준다. 이는 x가 벡터 각각에 계산을 실행한다."

# ╔═╡ c9c3bf47-e02b-44de-93de-7a5c80e66268
g.(x)

# ╔═╡ 144ccfbf-ec72-4e6f-951d-23d7503c3ac9
plot(x,g.(x))

# ╔═╡ a2047196-b9c0-45c3-adb6-3ecb4eb777c1
md"##### 풀이 3:배열과 함수 자체만 입력한 풀이"

# ╔═╡ 21e79379-eb99-4f4b-9b37-4a9424d429a6
plot(x,g)

# ╔═╡ 994c148e-eef2-4789-82b5-9044b7cecd2b
plot(g,x) # 바꾸어도 가능

# ╔═╡ 7e2f22dd-c410-410a-9460-97669ce2df41
plot(x,(x -> x^2) ∘ (x -> x-1)) # g대신 (x -> x^2) ∘ (x -> x-1)을 입력한 것과 같음

# ╔═╡ bf6cb62a-6e08-4e32-99d1-27b2736b2d0e
plot((x -> x^2) ∘ (x -> x-1),x) 

# ╔═╡ 29e6a939-0026-4460-8770-e8a6e3900281
md"###### 풀이 3 응용:"

# ╔═╡ 81cfed6c-85ab-498b-a618-532a084ddc41
md"`-` plot다음에 `!`를 입력하면 그림을 기존 그림에 추가하여 그릴 수 있다. 두 번째 플랏부터는 `plot!`를 사용한다"

# ╔═╡ ac93446f-a563-45d2-a3e5-047e60f91d7a
plot(x, sin); plot!(x, cos); plot!(x,x -> (x-1)^2)

# ╔═╡ 0751a773-9e74-4a53-b0b4-30342f4aeb09
md"##### 풀이 4:파이프연산자를 활용한 풀이
R에서 %>%와 같은 기능"

# ╔═╡ 15fba3e2-8122-485a-8d97-a8883e284283
x

# ╔═╡ f18006c5-b890-427c-bfc5-bcc21864338c
x .|> x -> x-1 .|> x -> x^2

# ╔═╡ 50e1c46d-e121-4209-84a8-9e4a9136ce31
plot(x, x.|> x -> x-1 .|> x -> x^2)

# ╔═╡ 74959246-cc53-44f6-a205-fea6e0ad8c26
md"##### 기타풀이"

# ╔═╡ f073c1a0-91ab-43c9-916d-e104cc71863d
md"###### (1): 함수 선언시 브로드캐스팅 활용"

# ╔═╡ 3eef9f0a-052b-4b3c-83e9-deb26ff69ed0
g_ = (x -> x.^2) ∘ (x -> x.-1)

# ╔═╡ 1fc7bb52-0937-471e-a2fe-1ff8559def29
g_(1)

# ╔═╡ 933c1ebc-75aa-4df8-9a1d-f8623fa522bc
g_(2)

# ╔═╡ b9c212f7-b774-4d47-9d30-85c3a5401d92
g_([0,1,2])

# ╔═╡ 473d2322-573f-4337-9a97-11592eedc72a
plot(x,g_(x))

# ╔═╡ f3a9b841-0da7-4469-a3e4-c8c96e4b926b
md"- 이는 어떻게 보면 더 확장성있는 코드가 아닐까? 우리가 함수를 사용할 때 기대하는 건 x값에 함수를 적용시켜주는 것이니까! 즉, 브로드캐스팅이 당연히 일어날 거라고 생각하고 쓰기 때문! 따라서 함수 자체에 브로드캐스팅이 되어 있으면 이를 해결할 수 있고 x에 어떤 값이 오더라도 계산해낼 수 있으니까!"

# ╔═╡ 22691e47-16aa-414e-b845-bc9b1cc9a8be
md"###### (2): 함수를 출력으로 받는 함수"

# ╔═╡ ac3a964a-a9f2-4b3b-9e43-95c6e8a075fa
h(x) = (x -> x^2) ∘ (x -> x-1) 
# h(x)는 입력이 x, 출력이 (x -> x^2) ∘ (x-> x-1)인 함수 = 함수를 출력하는 함수

# ╔═╡ 1b4800f2-9b28-42fb-a886-29725865902e
h(-1)

# ╔═╡ 84b20e0f-244f-4ae5-9225-7a98cb8dfff7
h(0)

# ╔═╡ 8cf0d60b-e5a3-4b8c-8425-e44cf5e6fe26
md"- 위 h(-1)과 h(0)은 입력값에 따라 결과가 바뀌는 것이 아니라 둘 다 (x -> x^2) ∘ (x-> x-1)를 출력한 것임
- 이는 풀이 1에서 g= (x -> x^2) ∘ (x -> x-1) 선언하고 g만 출력한 것과 유사"

# ╔═╡ 5f556e7a-ce48-46c7-8cf5-f8cfa60349e3
g

# ╔═╡ ce05e690-c408-4bb9-9ffd-144fdf98b179
g(0)

# ╔═╡ b2b61a3c-b88c-47c6-89aa-1766b09e2cbc
h(-1)(1)

# ╔═╡ b7cb9a30-a64b-4f29-bb14-0c2ce29c4307
h(0)(1)

# ╔═╡ dfec062d-caf7-46e7-8c8b-7a070672c6cb
h(-1)(0)

# ╔═╡ 5839bcf8-e7f3-4ce9-a667-371cfde68c7e
h(0)(0)

# ╔═╡ 1988c675-c5b5-497b-a4ab-877c065644da
h(x)(0)

# ╔═╡ 51a6c6e8-e2d9-433a-8486-c51b1bd8e934
plot(x,h(x))

# ╔═╡ 33240ae4-3d35-4acc-b2fd-e93c7e3b8737
plot(x,h(0))

# ╔═╡ 69e3c058-4546-4636-902e-2455f34e0126
md"- h(0)이 함수 자체이기 때문에 위와 같은 코드도 가능하다
- 즉, h(0) = h(x) = h(1)"

# ╔═╡ b22ae802-333a-4980-a70f-4ad3b0702dcc
md"##### 함수를 출력으로 하는 함수"

# ╔═╡ f51d0456-7ca2-4ac3-9af5-a1235ed5ed61
_h(x) = if x>0 x -> x+1  else x -> -x+1 end 

# ╔═╡ d76f9731-ac94-4ae9-be58-458485b7aba5
md"- x가 양수이면 x+1을 return(출력), x가 음수이면 -x+1을 return"

# ╔═╡ 66993258-4f82-4c91-8b5a-71ad5f28b10a
_h(0.1)(100) # x가 양수이기 때문에 x+1을 리턴 -> 101

# ╔═╡ 83dfc5a2-42a2-4a71-986f-02e4a934754c
_h(0.1) # x가 양수이기 때문에 x+1을 리턴하는 함수

# ╔═╡ 1eb92677-19b5-4a82-bf70-f6bc286eb1aa
_h(-0.1)(100) # x가 음수이기 때문에 -x+1을 리턴 -> -99

# ╔═╡ 00bca103-af06-4360-8c4a-a4098bca7c30
_h(-0.1) # x가 음수이기 때문에 -x+1을 리턴하는 함수

# ╔═╡ 68d78004-8e8e-40c0-b17a-729d47e33df6
plot(_h(1),-2:0.05:2); plot!(_h(-1),-2:0.05:2)

# ╔═╡ cdf1cd58-bc91-4bff-89e5-7c011b8cb365
plot(-2:0.05:2,_h(1)); plot!(-2:0.05:2,_h(-1))

# ╔═╡ 9b82a19e-d357-4555-bec5-4af8aff71768
plot(_h(1),-2,2); plot!(_h(-1),-2,2) # 벡터의 형태말고 range의 형태로 넣어도 됨

# ╔═╡ 94c5b978-fa33-445e-a1f0-3e8ecd5fc329
md"### 함수고급"

# ╔═╡ b45ac581-d5d2-4df2-92dc-e7cdd9c3fb0c
md"##### 연산자는 사실 함수다!"

# ╔═╡ 8e518af2-90cf-4d48-a140-85eca62ef2fc
+(3,2)

# ╔═╡ c6493aff-e1da-441e-87e5-9ff15e440cf3
*(3*2)

# ╔═╡ 0aae0c3e-dcac-4205-9a43-de450697a637
g

# ╔═╡ 58e7532f-4f08-4cf6-bb21-3a8228450428
gg=g

# ╔═╡ 030febc2-bd9a-40f2-a59a-82abb0e93b0e
gg(0),g(0)

# ╔═╡ 6611b424-252b-44da-8ec7-a3c8c48dd3f6
md"- gg는 g와 같이 기능을 하는 함수"

# ╔═╡ f9361a82-e80d-4f41-837c-9888b40dd41b
myadd=+

# ╔═╡ f65e6509-f07a-458f-86df-3fdfc3437b67
myadd(3,2)

# ╔═╡ d72c0d29-c32d-4590-88bc-9a89788946ae
md"##### 브로드캐스팅
`-` 함수 뒤에 .

`-` 연산자 앞에 ."

# ╔═╡ f5e58ac9-e589-4493-a031-aeac45e16921
plot(0:0.01:2π, sin.(0:0.01:2π)) ; plot!(0:0.01:2π, .√(0:0.01:2π))

# ╔═╡ 56714e08-6d98-4e53-914e-b0b0107d20b7
md"##### 파이프연산자"

# ╔═╡ ffe6dcc2-4572-4f4b-b0a4-e880b487f675
md"###### 기본"

# ╔═╡ f0341c5d-4ad4-4452-b163-aed6e4ef478d
md"
`-` `x |> f` 는 `f(x)` 와 같다.

`-` `x |> f |> g`는 `g(f(x))`와 같다.

`-` `x |> f |> g |> h`는 `h(g(f(x)))`와 같다."

# ╔═╡ 9eeb365e-e7b0-4452-9a70-1a6106687422
0 |> x->x-1

# ╔═╡ a8b85553-4164-46c5-8855-222253959dcc
0 |> x->x-1 |> x->x^2

# ╔═╡ acb51aa5-2704-45ac-a302-a7739c057769
[1,0.5] .|> x->x-1 .|> x -> x^2

# ╔═╡ 1ec3d8f7-4bee-42b0-9178-ae1fa861fc89
md"###### 응용"

# ╔═╡ fd11a076-7c84-4df5-8208-f4d10d709f04
md"`-` 각각의 서로 다른 원소에 서로 다른 기능을 적용하는 기능"

# ╔═╡ f9c2f00b-fd6e-4543-9e4e-55ad65339025
1:4 .|> [x -> x+100, inv, x -> 5x, -]

# ╔═╡ 9b188d7b-9629-4f51-a46a-cfe5bc6a0f61
md"Tip: 브로드캐스팅의 생략
`-` `@.`를 맨 앞에 붙이면 모든 연산자, 함수가 브로드캐스팅되어 수행된다"

# ╔═╡ 7dad4256-91de-450b-98f3-00fa6a308c3c
sqrt.([2,4])

# ╔═╡ ab80752b-c6ba-493b-be0e-0b6847fa86a3
@. sqrt([2,4])

# ╔═╡ 739b2fd7-9477-45b0-91c4-8170fff328b4
.√(2:4)

# ╔═╡ 7571bd0a-a9c1-4643-8f75-c61b11c225ea
@. √(2:4)

# ╔═╡ a0db7ddd-6ebb-47ea-a6bd-864dc1256c0e
md"`-` 여러 연산을 한 번에 수행할 때 매우 편함!"

# ╔═╡ bd7f9b35-6b04-4c91-9fe7-8a4c0897c1ca
@. 0:0.05:2 |> x->x-1 |> x-> x^2

# ╔═╡ 4d5705b8-269a-4779-a32f-d39244b0a2d6
@. 0:0.05:2 |> x->x-1 |> x-> x^2 |> sin |> tan

# ╔═╡ b233992e-aeee-4673-b1f7-6d3625bdf490
md"##### 피보나치 수열
: 일반적인 수열과 달라 함수의 형태로 표현하기 어려움"

# ╔═╡ 3b948a24-fcfe-4e15-8ba1-e2806515af6d
n -> 3n-2

# ╔═╡ 8dd453df-040f-4f9a-b31b-b5d7f4173841
(n -> 3n-2)(5)

# ╔═╡ a8edfe27-07cf-4636-b3b4-a699c873407f
md"---"

# ╔═╡ 24ea9ca5-93a4-45a3-aa20-be1c794a6e50
md"###### 예비학습
`1)` 피보나치수열:    

(1) $a_1=a_2=1$

(2) $n\geq 3$일 경우 $a_n=a_{n-1}+a_{n-2}$"

# ╔═╡ 7a84a228-5afb-40f4-af62-2ce1c571222f
md"`2)` if문"

# ╔═╡ 90ceefbb-728e-463d-bcb4-f45dd0c5e311
md"`-` if문의 간단한 형태"

# ╔═╡ 731fe929-bd30-4a4d-9293-e4ee6f46cbc8
@bind n Slider(1:10, show_value=true)

# ╔═╡ 87b13cf7-5f5f-482f-9b62-b41ad336251e
n ≤2 ? println("2보다 작거나 같음") : println("2보다 큼") 

# ╔═╡ 9352e2ec-3800-40e1-86d7-0dd1411b8c8d
if n ≤ 2
	println("2보다 작거나 같음")
else
	println("2보다 큼")
end

# ╔═╡ 420748bf-61d4-4654-a603-164ef91e8fa6
md"- 위 두 코드는 같음"

# ╔═╡ f4d97fd7-4bcb-4d33-85fe-5089338d0b66
md"---"

# ╔═╡ 97d8f36d-205e-4464-b1f6-685faaa13e51
a(n) = n ≤ 2 ? 1 : a(n-1)+a(n-2)

# ╔═╡ 2b313f33-e937-497e-8349-5e0ea16f5f1a
scatter(1:8,a)

# ╔═╡ 7171ec36-6eb4-42fe-84d8-634070c3447b
a(n)

# ╔═╡ 1c860d75-7aa3-4719-8b2a-48a78fc08e9f
a

# ╔═╡ aeb13e15-f3c2-4616-af43-98ddb1a274be
md"###### 추가학습
`-` 초항이 2이고 공차가 3인 수열을 점화식의 형태로 정의하여 보라. 1항부터 10항지의 출력결과를 시각화하라."

# ╔═╡ 20425479-a928-4472-bb26-fea25878999c
b(n) = n ≤ 1 ? 2 : b(n-1) + 3

# ╔═╡ d60d3d6a-2178-4f40-8118-1a0a6df8a1bf
q = [b(n) for n in 1:10]

# ╔═╡ 6a45464c-bdde-490b-bb00-d1aa4ad6ba87
@bind col ColorStringPicker()

# ╔═╡ 28623eb6-4cea-4aef-a616-57690ca475cc
scatter(q,b,color=col)

# ╔═╡ d8ee46fe-0af9-4b7e-820f-2e67ab3509ac
j=0

# ╔═╡ a7e74646-affe-48f2-ac72-0c288ee25095
j=1

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
Plots = "~1.27.1"
PlutoUI = "~0.7.37"
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

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "c9a6160317d1abe9c44b3beb367fd448117679ca"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.13.0"

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

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "b19534d1895d702889b219c382a6e18010797f0b"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.6"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3f3a2501fa7236e9b911e0f7a588c657e822bb6d"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.2.3+0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ae13fcbc7ab8f16b0856729b050ef0c446aa3492"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.4+0"

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
git-tree-sha1 = "9f836fb62492f4b0f0d3b06f55983f2704ed0883"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.64.0"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Pkg", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "a6c850d77ad5118ad3be4bd188919ce97fffac47"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.64.0+0"

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
git-tree-sha1 = "4f00cc36fede3c04b8acf9b2e2763decfdcecfa6"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.13"

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

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ab05aa4cc89736e95915b01e7279e61b1bfe33b8"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.14+0"

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

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "85b5da0fa43588c75bb1ff986493443f821c70b7"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.3"

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
git-tree-sha1 = "1690b713c3b460c955a2957cd7487b1b725878a7"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.27.1"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "bf0a1121af131d9974241ba53f601211e9303a9e"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.37"

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
git-tree-sha1 = "995a812c6f7edea7527bb570f0ac39d0fb15663c"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.5.1"

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

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "6976fab022fea2ffea3d945159317556e5dad87c"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.4.2"

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

[[deps.StructArrays]]
deps = ["Adapt", "DataAPI", "StaticArrays", "Tables"]
git-tree-sha1 = "57617b34fa34f91d536eb265df67c2d4519b8b98"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.5"

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
# ╠═70c27370-a8ed-11ec-318c-0783c2f81ddd
# ╟─585fa6ff-bc27-4fca-905f-73142cd53ca0
# ╟─810d60a7-cf24-4158-8bc7-aa5bdd2c9466
# ╟─869d2686-e0d9-4986-b392-61f665260e21
# ╠═d8ee46fe-0af9-4b7e-820f-2e67ab3509ac
# ╠═a7e74646-affe-48f2-ac72-0c288ee25095
# ╟─bb9782aa-1c02-4bd3-a9b9-389271a0ed90
# ╠═6ad29743-7bf7-4a40-8e97-037318a178e7
# ╟─ea96c5bb-578e-40aa-ba7f-9fc9bf8e8a20
# ╠═d51e351c-d49e-4694-8033-72b7904cb0e7
# ╟─200bff16-e4ca-4a0b-9c04-38817dcc241f
# ╠═3022fb9b-295d-4704-9dea-7ce8d6976a95
# ╠═91c00507-008c-47f2-8a57-10597bded7ef
# ╟─d98ab2cf-c309-46fd-b00d-bd0c54de7801
# ╟─790a77a9-b588-4943-b593-b38007a55988
# ╠═47c6f7d5-9733-42fd-a758-c9acefc8510a
# ╠═04b42ea9-2ac6-48c1-8101-5d3588379f3c
# ╟─afb88fbb-cf0c-4000-b282-3ed902cd05ab
# ╟─4a10b8a7-3433-4fbc-b749-738ef27088d2
# ╠═5c196190-f3a2-475e-b218-df66c6e162d6
# ╠═b4ad0cf3-fa03-43de-a5e5-e0a12bd0d926
# ╠═b2e5b4fe-5829-4f73-b318-1e787ff525d6
# ╠═d1b4fc80-6344-4719-9b72-442ea651dce0
# ╠═6543455e-d8cf-4ac8-823d-5c700ee8eefb
# ╟─19d99419-f77c-43de-b8a0-55753267d9dc
# ╟─5311d732-273c-4a15-b4a4-5af1b22371a8
# ╠═4cd85a87-f1ae-4c3c-85c9-dcac78de5e0f
# ╠═4493a6d3-e6a0-45c9-b57d-1cb15e6f3df0
# ╟─274a7733-21f8-4cba-90c6-8e5b2e2b7852
# ╟─5e964ff6-a017-43e7-86bd-94e1e99a1339
# ╠═722d1f4f-c465-4d72-9c1f-2e40d208f95a
# ╠═eb5cad66-1712-49f3-8efe-16d120cc3264
# ╟─ae037d9a-fa76-44ce-b0a8-e358edfb07cf
# ╟─c03800cf-41b8-4ce4-b914-6c60c3cfabe6
# ╠═c9c3bf47-e02b-44de-93de-7a5c80e66268
# ╠═144ccfbf-ec72-4e6f-951d-23d7503c3ac9
# ╟─a2047196-b9c0-45c3-adb6-3ecb4eb777c1
# ╠═21e79379-eb99-4f4b-9b37-4a9424d429a6
# ╠═994c148e-eef2-4789-82b5-9044b7cecd2b
# ╠═7e2f22dd-c410-410a-9460-97669ce2df41
# ╠═bf6cb62a-6e08-4e32-99d1-27b2736b2d0e
# ╟─29e6a939-0026-4460-8770-e8a6e3900281
# ╟─81cfed6c-85ab-498b-a618-532a084ddc41
# ╠═ac93446f-a563-45d2-a3e5-047e60f91d7a
# ╟─0751a773-9e74-4a53-b0b4-30342f4aeb09
# ╠═15fba3e2-8122-485a-8d97-a8883e284283
# ╠═f18006c5-b890-427c-bfc5-bcc21864338c
# ╠═50e1c46d-e121-4209-84a8-9e4a9136ce31
# ╟─74959246-cc53-44f6-a205-fea6e0ad8c26
# ╟─f073c1a0-91ab-43c9-916d-e104cc71863d
# ╠═3eef9f0a-052b-4b3c-83e9-deb26ff69ed0
# ╠═1fc7bb52-0937-471e-a2fe-1ff8559def29
# ╠═933c1ebc-75aa-4df8-9a1d-f8623fa522bc
# ╠═b9c212f7-b774-4d47-9d30-85c3a5401d92
# ╠═473d2322-573f-4337-9a97-11592eedc72a
# ╟─f3a9b841-0da7-4469-a3e4-c8c96e4b926b
# ╟─22691e47-16aa-414e-b845-bc9b1cc9a8be
# ╠═ac3a964a-a9f2-4b3b-9e43-95c6e8a075fa
# ╠═1b4800f2-9b28-42fb-a886-29725865902e
# ╠═84b20e0f-244f-4ae5-9225-7a98cb8dfff7
# ╟─8cf0d60b-e5a3-4b8c-8425-e44cf5e6fe26
# ╠═5f556e7a-ce48-46c7-8cf5-f8cfa60349e3
# ╠═ce05e690-c408-4bb9-9ffd-144fdf98b179
# ╠═b2b61a3c-b88c-47c6-89aa-1766b09e2cbc
# ╠═b7cb9a30-a64b-4f29-bb14-0c2ce29c4307
# ╠═dfec062d-caf7-46e7-8c8b-7a070672c6cb
# ╠═5839bcf8-e7f3-4ce9-a667-371cfde68c7e
# ╠═1988c675-c5b5-497b-a4ab-877c065644da
# ╠═51a6c6e8-e2d9-433a-8486-c51b1bd8e934
# ╠═33240ae4-3d35-4acc-b2fd-e93c7e3b8737
# ╟─69e3c058-4546-4636-902e-2455f34e0126
# ╟─b22ae802-333a-4980-a70f-4ad3b0702dcc
# ╠═f51d0456-7ca2-4ac3-9af5-a1235ed5ed61
# ╟─d76f9731-ac94-4ae9-be58-458485b7aba5
# ╠═66993258-4f82-4c91-8b5a-71ad5f28b10a
# ╠═83dfc5a2-42a2-4a71-986f-02e4a934754c
# ╠═1eb92677-19b5-4a82-bf70-f6bc286eb1aa
# ╠═00bca103-af06-4360-8c4a-a4098bca7c30
# ╠═68d78004-8e8e-40c0-b17a-729d47e33df6
# ╠═cdf1cd58-bc91-4bff-89e5-7c011b8cb365
# ╠═9b82a19e-d357-4555-bec5-4af8aff71768
# ╟─94c5b978-fa33-445e-a1f0-3e8ecd5fc329
# ╠═b45ac581-d5d2-4df2-92dc-e7cdd9c3fb0c
# ╠═8e518af2-90cf-4d48-a140-85eca62ef2fc
# ╠═c6493aff-e1da-441e-87e5-9ff15e440cf3
# ╠═0aae0c3e-dcac-4205-9a43-de450697a637
# ╠═58e7532f-4f08-4cf6-bb21-3a8228450428
# ╠═030febc2-bd9a-40f2-a59a-82abb0e93b0e
# ╟─6611b424-252b-44da-8ec7-a3c8c48dd3f6
# ╠═f9361a82-e80d-4f41-837c-9888b40dd41b
# ╠═f65e6509-f07a-458f-86df-3fdfc3437b67
# ╠═d72c0d29-c32d-4590-88bc-9a89788946ae
# ╠═f5e58ac9-e589-4493-a031-aeac45e16921
# ╟─56714e08-6d98-4e53-914e-b0b0107d20b7
# ╟─ffe6dcc2-4572-4f4b-b0a4-e880b487f675
# ╟─f0341c5d-4ad4-4452-b163-aed6e4ef478d
# ╠═9eeb365e-e7b0-4452-9a70-1a6106687422
# ╠═a8b85553-4164-46c5-8855-222253959dcc
# ╠═acb51aa5-2704-45ac-a302-a7739c057769
# ╟─1ec3d8f7-4bee-42b0-9178-ae1fa861fc89
# ╟─fd11a076-7c84-4df5-8208-f4d10d709f04
# ╠═f9c2f00b-fd6e-4543-9e4e-55ad65339025
# ╟─9b188d7b-9629-4f51-a46a-cfe5bc6a0f61
# ╠═7dad4256-91de-450b-98f3-00fa6a308c3c
# ╠═ab80752b-c6ba-493b-be0e-0b6847fa86a3
# ╠═739b2fd7-9477-45b0-91c4-8170fff328b4
# ╠═7571bd0a-a9c1-4643-8f75-c61b11c225ea
# ╟─a0db7ddd-6ebb-47ea-a6bd-864dc1256c0e
# ╠═bd7f9b35-6b04-4c91-9fe7-8a4c0897c1ca
# ╠═4d5705b8-269a-4779-a32f-d39244b0a2d6
# ╟─b233992e-aeee-4673-b1f7-6d3625bdf490
# ╠═3b948a24-fcfe-4e15-8ba1-e2806515af6d
# ╠═8dd453df-040f-4f9a-b31b-b5d7f4173841
# ╟─a8edfe27-07cf-4636-b3b4-a699c873407f
# ╟─24ea9ca5-93a4-45a3-aa20-be1c794a6e50
# ╟─7a84a228-5afb-40f4-af62-2ce1c571222f
# ╠═1db3e688-6da6-45a9-81f8-c5c0b24a9782
# ╟─90ceefbb-728e-463d-bcb4-f45dd0c5e311
# ╠═731fe929-bd30-4a4d-9293-e4ee6f46cbc8
# ╠═87b13cf7-5f5f-482f-9b62-b41ad336251e
# ╠═9352e2ec-3800-40e1-86d7-0dd1411b8c8d
# ╟─420748bf-61d4-4654-a603-164ef91e8fa6
# ╟─f4d97fd7-4bcb-4d33-85fe-5089338d0b66
# ╠═97d8f36d-205e-4464-b1f6-685faaa13e51
# ╠═2b313f33-e937-497e-8349-5e0ea16f5f1a
# ╠═7171ec36-6eb4-42fe-84d8-634070c3447b
# ╠═1c860d75-7aa3-4719-8b2a-48a78fc08e9f
# ╟─aeb13e15-f3c2-4616-af43-98ddb1a274be
# ╠═20425479-a928-4472-bb26-fea25878999c
# ╠═d60d3d6a-2178-4f40-8118-1a0a6df8a1bf
# ╠═6a45464c-bdde-490b-bb00-d1aa4ad6ba87
# ╠═28623eb6-4cea-4aef-a616-57690ca475cc
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
