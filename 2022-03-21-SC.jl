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

# ╔═╡ 156a5d9a-453a-49af-8dcd-891b4bf3d257
using Plots

# ╔═╡ 83d2d2cb-de4b-401c-8e45-2f94929374ad
using PlutoUI

# ╔═╡ 33a53520-a85e-11ec-13ad-ed6f43926530
md"# Statistic Computing

topic: 매트릭스, 벡터와 매트릭스, 인덱싱, 함수선언

lecture: Statistic Computing_2-2st

lecture date: 2022-03-15

professor: Guebin Choi

study date: 2022-03-21

author: Kione KIm
"

# ╔═╡ ef3b93d7-5087-4549-bd73-8eb05599b640
md"### matrix (자세히)"

# ╔═╡ f0fe7356-5c52-41b6-8716-a209aa04f881
md"#### 선언"

# ╔═╡ 14db2de1-ae5b-4841-983f-60a4b3c3efc4
md"###### `-` 선언하는 방법"

# ╔═╡ 4bbf5eed-30e1-4ad0-a6d8-d06deafa5c3a
md"방법 1: `;`사용 `;`는 거의 엔터라고 생각하면 된다"

# ╔═╡ 450f4303-45bc-4b81-88ac-84159cd8900c
[1 2 3; 4 5 6]

# ╔═╡ 4fcc0de3-6144-4aa4-b738-35ad5e6a9e3b
md"방법 2"

# ╔═╡ b36a4db1-2b2e-4f29-9bcb-438f8e381e7c
[1 2 3;
	4 5 6]

# ╔═╡ c6af262b-1049-4767-95f7-5d14d4dd26c9
md"방법 3: `;`대신 그냥 엔터를 쳐도 선언 가능하다"

# ╔═╡ e35b7c2a-7d0a-40ae-a5a9-43bda0a8e8c5
[1 2 3
4 5 6]

# ╔═╡ 32cf9baa-e900-48a9-b1af-79da69fbee38
md"방법 4: 직관적인 방법"

# ╔═╡ a3794873-9fda-4df3-bf76-4d00b75fa871
[
	1 2 3
	4 5 6
]

# ╔═╡ af611b84-8e76-4718-99ad-7ddf8460fc62
md"###### `-` (1,4) matrix = 길이가 4인 row-벡터"

# ╔═╡ 86985ca9-34a9-427c-a30f-8250105a4010
md"방법 1"

# ╔═╡ d495fd29-4913-4fbc-b3a8-4b410db9fe0b
[1 2 3 4]

# ╔═╡ 33b7d35f-20cc-4b64-9955-54e1b2c48c6b
md"방법 2: 직관적이지 않지만 가능한 벙법"

# ╔═╡ 8589a7a6-077a-4dfb-beae-1ff209d7d5c6
[1 ;; 2 ;; 3 ;; 4]

# ╔═╡ 19d23e35-d7a8-48c1-b153-bdd76b9cb622
md"###### `-` (4,1) matrix = 길이가 4인 column-벡터"

# ╔═╡ 37cae432-0dfb-414f-9561-da633c9ed97e
md"방법 1"

# ╔═╡ 0b655f25-8ca8-4d64-bcee-58af417b6aca
[1,2,3,4]

# ╔═╡ 879e9e73-c1cb-42e3-8402-1dbbda23cf08
md"방법 2"

# ╔═╡ d474e61b-7e87-496d-85d2-e1b357ae989d
[1;2;3;4]

# ╔═╡ c19dd1ad-d767-4bed-8fd7-b4012b715614
md"방법 3: 직관적인 방법"

# ╔═╡ c13fe4bd-6ee9-4fe0-ad8f-9270d4a8d5c0
[
	1
	2
	3
	4
]

# ╔═╡ c608b8b3-ca99-4834-ae80-d542e25c22a7
md"###### `-` (4,2) matrix 선언과 잘못된 선언 "

# ╔═╡ 24835818-0acc-4cce-875d-365b0e67e43b
md"방법 1: `;`를 이용한 선언"

# ╔═╡ 5166cde5-458a-43a1-a1f7-7f9d5a640ba2
[1 2; 2 3; 3 4; 4 5]

# ╔═╡ ff9315a5-2e3b-486d-87be-d18aa7c377ee
md"잘못된 선언: column을 선언하는 기호인 `;`가 되니 `,`를 이용한 선언도 가능할까?
No"

# ╔═╡ 53a76b3f-2767-41d0-8b98-9b93259af434
[1 2, 2 3, 3 4, 4 5]

# ╔═╡ 7c52965b-292c-4fc9-a750-491c19a76a90
md"방법 2: 직관적이고 편한 방식"

# ╔═╡ 25091216-3054-4cc8-aaad-97227e2fe8c7
[
	1 2
	2 3
	3 4
	4 5
]

# ╔═╡ a9ec54d9-bd8b-4f9e-a80a-7d480c09570e
md"#### 연산"

# ╔═╡ 27c80071-8551-45c3-bde7-c55e956101b4
md"##### 곱셈"

# ╔═╡ de247493-0b9a-41ad-959a-d005e0d36405
[1 0; 0 1] * [1, 2]

# ╔═╡ ac937d1d-4cea-4988-87fb-f21f9db9e961
[1, 2] * [1 0; 0 1] # (2×1) * (2×2)

# ╔═╡ ed5b239f-b26c-4118-ba86-43888fcc5352
md"##### 트랜스포즈"

# ╔═╡ 68230afe-fdf9-4c43-a4ba-04a739cc0398
md"`-` 연산자 `'` 사용"

# ╔═╡ cf65c6ae-8fca-4389-ac76-b47aa2c976b0
[1 2 ; 3 4]

# ╔═╡ 2ddf9e71-261e-4e8b-ac2b-e67a1c8a1205
[1 2 ; 3 4]'

# ╔═╡ bb89b25a-fb41-403e-a30c-eeb6f909bd24
[1 2 3 4]

# ╔═╡ 56e720d8-0203-43ac-af39-097966c16619
[1 2 3 4]'

# ╔═╡ 4089dd78-e459-4060-b415-f6e21ab9d6e3
md"`-` 복잡한방법: `adjoint`함수 사용"

# ╔═╡ d57f0b9d-d22b-4529-a99a-59d7009b7a93
adjoint([1 2; 3 4])

# ╔═╡ 7442010c-06e5-477c-8f05-1a9d03294901
adjoint([1 2 3 4])

# ╔═╡ e06df9db-cd2f-4b41-8ac7-1966a3ee7fdd
md"""#### `-` hcat, vcat 
- hcat: R에서의 cbind, 옆으로 붙인다
- hcat: R에서의 rbind, 아래로 붙인다
"""

# ╔═╡ 4c40caea-cd53-40c5-9eae-0e826ebf2117
md"##### hcat"

# ╔═╡ 9f78c3bc-42e4-4e51-b0e6-ff2601d8720b
md"3×1 col-vec (hcat) 3×1 col-vec -> 3×2 matrix"

# ╔═╡ a0571c3a-1218-4e13-9ed2-5c9d3ad2298e
hcat([1,2,3],[4,5,6])

# ╔═╡ 2b3fd404-a381-42e7-a778-0883eb6c5c72
md"3×1 col-vec (hcat) 3×1 col-vec (hcat) 3×1 col-vec-> 3×3 matrix"

# ╔═╡ b43504c0-5026-4e7d-998d-f1aefef67536
hcat([1,2,3],[4,5,6],[7,8,9])

# ╔═╡ 9bf1473b-e0c3-4610-885b-3cc612c19eca
md"3×2 col-vec (hcat) 3×1 col-vec -> 3×3 matrix"

# ╔═╡ 177ae1ba-e230-4931-b4a9-041bdf0bf012
hcat([1 11; 2 22; 3 33],[7,8,9])

# ╔═╡ ea417c47-662e-488e-a7fc-5ce80e48b832
md"차원이 맞지 않으면 오류"

# ╔═╡ 1b02d3ce-5f4f-4ed2-b846-187292924ea7
hcat([1 11;2 22;3 33],[1 2 3])

# ╔═╡ c76145c8-a5e0-4b71-bfa8-8774006fa092
md"##### vcat"

# ╔═╡ 8966d471-4883-4b54-8e2e-27315ff09d39
md"1×4 row-vec (vcat) 1×4 row-vec -> 2×4 matrix"

# ╔═╡ 83d67ad5-3dee-4399-b359-16db76512d6a
vcat([1 2 3 4], [5 6 7 8])

# ╔═╡ b30cc74a-af46-4201-981e-134f86941ff1
md"혼합하여 사용"

# ╔═╡ 3e3ed224-b9f0-4b5d-ad75-ab755da3eb51
hcat(vcat([1 2 3 4],[5 6 7 8]),[3,2])

# ╔═╡ 41f86a23-b4c8-4381-abbc-c9cc83a69dc3
vcat(hcat(vcat([1 2 3 4],[5 6 7 8]),[3,2]),[3 3 3 2 2])

# ╔═╡ 7de224a1-dd52-40a8-8cd6-656c7ef2d0fb
md"##### hcat, vcat의 더 쉬운 사용방법"

# ╔═╡ f95e1bca-881b-4728-804d-788f91b5f44b
hcat([1, 2],[4, 5])

# ╔═╡ e3c97fa5-432d-47ce-afc2-ad59a82932e5
md"`-` hcat의 경우 [ [   ]  [   ] ]처럼 vec와 vec 사이에 아무것도 입력하지 않는 것이다"

# ╔═╡ e029c2d7-f47a-45bf-8bac-0a4a911bc974
[[1, 2, 3] [4, 5, 6]]

# ╔═╡ df553080-c406-4497-a408-ab2437953f89
vcat([1 2],[3 4])

# ╔═╡ 729f4d42-3f5a-4bb4-ac4e-58ab70c2718f
md"`-` vcat의 경우 [ [ ];[ ] ]처럼 vec와 vec 사이에 `;`를 입력해주는 것이다"

# ╔═╡ 6b75f2dd-5ef2-40f0-af4d-c471540091fd
[[1 2]; [3 4]]

# ╔═╡ 8abaa9bf-f668-4684-88c7-b8b130a9a0c0
[[1 2 3; 4 5 6];[7 8 9]]

# ╔═╡ 2a33a664-a76e-4942-9b2a-9e3170d6188a
[
	[1 2 3;	4 5 6]
	[7 8 9]
]

# ╔═╡ 387a1e14-def6-4e32-8d43-a0f809145ae5
[
	[1 2 3
	4 5 6]
	[7 8 9]
]

# ╔═╡ 12a6c74c-b2f9-4fd1-bb01-3584d1e93431
md"- 이는 위의 코드처럼 사용하기 편리하다"

# ╔═╡ 0d235e4a-0d34-4442-bed6-94f58c05018d
md"`-` 아래와 같이 사용도 가능하다"

# ╔═╡ 8975240b-6b14-4d66-8b28-2f1cfcd417bd
a1=[1 2; 4 5]

# ╔═╡ 1a0a1e92-c8e6-443d-8fde-bb66ded09898
a2=[3, 6]

# ╔═╡ 699f0742-62ce-431d-b412-56cd6adef7cb
a3=[7 8]

# ╔═╡ 88b25266-ca94-495f-a2d4-5d02872395d4
[
	a1 a2
	a3 9
]

# ╔═╡ cb9585a8-192c-4ab1-8c8c-376e8e7d66ae
md"그러나 차원이 맞지 않으면 오류가 난다"

# ╔═╡ d69eb5c4-a221-4037-8cb0-7eb9c652df2a
[
	a1 a3
	a2 9
]

# ╔═╡ e51791ac-be42-4921-b563-e63d0b66a859
md"##### reshape"

# ╔═╡ 89690f01-1bac-4169-b68f-4842dd0c8997
reshape(1:6,(3,2))

# ╔═╡ e9bb456b-6dc7-4acd-86bc-24602d085d20
reshape(1:6,(6,1))

# ╔═╡ 988beb71-f9c1-4908-acd9-e07163251865
md"`-` 3차원도 가능"

# ╔═╡ e60ed9fb-9a7a-4606-a480-34bd9bbb3b1f
reshape(1:12,(2,2,3))

# ╔═╡ 568c72d8-ae56-4844-9124-5896774eafa1
reshape(1:12,(3,2,2))

# ╔═╡ 0f9eb977-3b3e-4303-881e-f8d4949c655c
md"### 벡터와 매트릭스(자투리)"

# ╔═╡ 4b9dd218-646f-4236-8655-115544e5a4c8
md"#### Range"

# ╔═╡ f84bf4fd-a0a5-4d53-9d35-8d3ecab5f08c
1:3

# ╔═╡ ad7c4031-f0e5-4d78-aa52-c542814f73a6
typeof(1:3)

# ╔═╡ b0444597-c514-44d6-8b73-e6254471e067
md"- 1:3의 타입은 `UnitRange`인데 이게 무얼 의미하는걸까? -> array()에 입력해보자"

# ╔═╡ c942ca59-4f5c-43ad-82df-612503aa4796
Array(1:3)

# ╔═╡ 8a0d7fa1-e27f-4215-b41b-f70065b55e4f
typeof(Array(1:3))

# ╔═╡ ffd03bbb-ed15-4eb1-913e-701031bf88d4
md"- Array(1:3)의 타입은 벡터네!"

# ╔═╡ 0c58aa51-4c58-4ea8-b69a-3e9373079fdc
md"`-` 다음도 마찬가지"

# ╔═╡ 9bca53ff-b63f-40a3-9d63-c704fceaa2c3
1:2:9

# ╔═╡ 9ad0e6d5-5fea-440b-b49a-7d2dc8a90c7a
Array(1:2:9)

# ╔═╡ 29b7109a-580d-47f0-b74f-07e2a80d0b9f
md"`-` range도 연산이 가능함"

# ╔═╡ a9e5a72a-5aa8-4793-8e8a-f9254bb12bd9
(1:3) + (1:3)

# ╔═╡ 7db1f547-c285-4864-9f09-6ebdd849cb4e
Array((1:3) + (1:3))

# ╔═╡ 2a99d6d0-c787-4d7c-a29f-5592cad60964
md"- 이는 (1 2 3) + (1 2 3) = (2 4 6)이 된 것임! 또한, (2 4 6)은 2에서 6까지 2칸씩을 의미하는 2:2:6과 같다! 그래서 위의 2:2:6이 나오는 것! "

# ╔═╡ efb04759-1ac7-4496-a778-5f3f0f953c12
md"`-` 연산자(+ * 등등) 앞에 `.`을 찍어주면 broadcasting 연산이 가능함, `.`을 찍지 않으면 오류가 남"

# ╔═╡ b53c9bf8-efdd-49a9-9e85-bfb47df7b1c7
(1:3) .+ 1

# ╔═╡ 173ccdd7-454f-43df-8723-7af9633cf417
Array((1:3) .+ 1)

# ╔═╡ e174f8e8-9514-4ba8-91d5-5c0a7315c6ce
(1:3) .* 100 .+ 5

# ╔═╡ ca6330f0-5463-4786-854b-bc95e3a86203
Array((1:3) .* 100 .+ 5)

# ╔═╡ b13ab2d6-1bff-40b8-b2be-19f18cd44b38
(1:3) + 1

# ╔═╡ 612bfc86-43f4-4467-aea7-cd1cec7ef11d
md"### index"

# ╔═╡ 2703c08c-9294-4c8f-99f6-75655d14c6c7
md"`-` 1차원으로 인덱싱"

# ╔═╡ 68556616-54ca-4823-9415-5197980597ad
a=[
	1 2 3
	4 5 6
	7 8 9
]

# ╔═╡ c90f2710-b3dd-4457-af8d-f4dd3bc22e2d
a[[1,3,5,7]]

# ╔═╡ f32cd38f-43d1-41b5-9068-905e86a10d56
a[1:3] # 첫 번째 원소는 첫 col에 첫 원소, 두 번째 원소는 첫 col에 두 번째 원소, 세 번째 원소는 첫 col에 세 번째 원소 

# ╔═╡ 1b1911a2-9e86-47dc-870f-86335da20565
a[4:9]

# ╔═╡ 8eec5e28-ef90-46eb-bb56-4bdae4397274
md"`-` 2차원으로 인덱싱"

# ╔═╡ b9b1da61-788f-49ca-9910-2cc4de6062fb
a[1,:] # 첫 row 인덱싱

# ╔═╡ 33c3eb29-3854-4e55-93b1-0750c005f351
a[[1],:] # 좀 더 명시적

# ╔═╡ e622b92c-6898-4deb-b91c-8c7f62cb3dfe
a[2,:]  # 두 번째 row 인덱싱

# ╔═╡ 73cd9487-0ae7-4340-9588-9d1e26150212
a[[2],:] # 좀 더 명시적

# ╔═╡ 0e901426-2706-4fea-a05a-66066997885e
a[:,1] # 첫 column 인덱싱

# ╔═╡ 0a4d8787-a78b-4f55-bca1-2c117eb58b62
a[:,[1]] # 좀 더 명시적

# ╔═╡ 35f8b3bf-1f65-4f7e-bced-d82c69ddebd1
a[:,3] # 세 번재 column 인덱싱

# ╔═╡ 47564629-530c-4d53-9bc3-f46a05a3b16b
a[:,[3]] # 좀 더 명시적

# ╔═╡ 387bfdf3-a378-4e63-84ca-13dd25c92af7
a[[1,2],:] # 1,2 row 인덱싱

# ╔═╡ 2b00902c-16d8-4c30-b200-6def0d62e806
a[:,[1,3]] # 1,3 column 인덱싱

# ╔═╡ e8484aa7-f542-4735-93e4-b1d45ac68539
a[[1,2],3] # 1,2 row & 3 column 인덱싱

# ╔═╡ 0c5f907f-4f0e-4b53-872c-eb874e12e8a9
a[[1,2],[3]] # 좀 더 명시적

# ╔═╡ 97959485-027a-4d4d-9ec8-cdf29b9cf90e
md"`-` 고차원 인덱싱"

# ╔═╡ 01dc10ee-3b59-4c96-a8ae-f23820a8dd0d
b=reshape(1:36,(3,3,2,2))

# ╔═╡ 4a475bae-639e-4d14-a70d-544e3b7b2b5d
b[1:2, 2:3, 1, :]

# ╔═╡ 7ab7b939-b8f6-45ec-9237-42b45754dacf
md"- 인덱싱 적용: 첫 번째 숫자- row, 두 번째 숫자- col, ..."

# ╔═╡ efeb5de8-a351-4007-bfe0-16b15e49e089
b[[2,3], 1:2, :, 2]

# ╔═╡ fc13dba3-63b7-48cb-b8a3-b53cdc5efa8f
md"`-` 로지컬 인덱싱"

# ╔═╡ 9db0f80b-8e49-44dc-bf7b-1ea3177ad317
c=[1 2 3 4]

# ╔═╡ c8ef1e64-e6ef-49a1-86ed-4b197ec17c5d
c[[true,true,false,false]]

# ╔═╡ d47d185a-eb61-40e8-b4ff-dbd111911d8f
c[c.>2] # 앞에 .을 찍어주어야 한다.

# ╔═╡ 5cf760ad-b9c4-4209-93e6-e91edce2bd9e
md"### 함수선언"

# ╔═╡ 29aa5088-5751-45a6-b90b-b15b53d6d028
md"`-` 스타일 1: return 명시"

# ╔═╡ 5eb984af-a789-405c-b5ca-2d3975b539ed
function f1(x,y)
	return √(x^2+y^2)
end

# ╔═╡ 17aa70b1-522c-4138-a86d-7d9d488e1b8e
f1(1,1)

# ╔═╡ aa0a539d-1efb-4246-af6d-261c7a39c6da
md"`-` 스타일2: return 생략"

# ╔═╡ c7f302f5-af1f-4c7b-baba-210e8b1a5518
function f2(x,y)
	√(x^2+y^2)
end

# ╔═╡ 515fa5e0-b709-412c-a032-80fff1012527
f2(1,1)

# ╔═╡ 783a461e-e383-464c-a78e-487b0bd04955
md"`-` 스타일3: 변수로 입력, return 생략(마지막 값으로 리턴됨)"

# ╔═╡ 15cf0ac8-5fcc-40bf-81d4-ad8b87cc7d32
function f3(x,y)
	a=x^2+y^2
	√a
end

# ╔═╡ 51e1e257-93ab-48a0-bfe4-9ab44ac86ee1
f3(1,1)

# ╔═╡ bb5dc061-4a72-4075-a50d-7440900d87da
md"`-` 스타일 4: function, return, end 생략, `=`로 입력"

# ╔═╡ 38d85648-31a9-4078-b373-9522ebd9f0a9
f4(x,y) = √(x^2+y^2)

# ╔═╡ e3ba7692-96e0-4959-99b6-f358cfee554a
f4(1,1)

# ╔═╡ e8d5a0b6-feb2-44ac-8920-e4b980b2ab54
md"`-` 스타일 5"

# ╔═╡ d99b66fc-1d03-486b-8bcb-73559aa2a6ae
f5 = (x,y) -> √(x^2+y^2)

# ╔═╡ 7f3bf3f9-40ba-4894-871a-9517af0341d7
f5(1,1)

# ╔═╡ 109b6043-3ae6-4a90-a57f-8ea6bc6e8fdc
md"`-` 스타일 6: 익명함수"

# ╔═╡ 7234f40d-a032-4e75-abe0-9225c23ff21f
(x,y) -> √(x^2+y^2)

# ╔═╡ fdd07160-dc8e-4289-8ede-e0b460de906e
((x,y) -> √(x^2+y^2))(1,1)

# ╔═╡ c033b84b-8d9a-4a8c-9df2-5767a87ec8d7
md"#### 합성함수"

# ╔═╡ c25fbece-a5cc-4f67-b25e-1bc774c8e8dd
(x -> 3x)

# ╔═╡ c36029fd-f0a3-4cda-a6f6-1441bb68425c
md"- 이 자체가 함수"

# ╔═╡ d3d58b6c-fcc5-4c67-8011-060c80102e4e
(x -> 3x)(100)

# ╔═╡ 930c0125-e7cf-4962-b953-cf58e15e947c
(x -> x+1)

# ╔═╡ de3830b0-8455-4bc4-88dc-2c2b62ec4600
md"- 이것도 마찬가지"

# ╔═╡ 99cd5882-90f5-4f91-a458-2f1f603728d1
(x -> x+1)(10)

# ╔═╡ 8df7c994-8cab-4527-bccb-9640c76a13e0
md"`-` 합성함수 선언 `\circ + tab` 이용"

# ╔═╡ 413b409e-4741-4cf0-bff1-8fdca171b400
(x -> 3x) ∘ (x -> x+1)

# ╔═╡ 9f06cef0-5b2a-4d18-9323-b8c19855f37e
md"`-` 계산 1: (힙성함수)(입력값)"

# ╔═╡ 8aae5504-e937-403a-a809-a4ba5c51d6e6
((x -> 3x) ∘ (x -> x+1))(3)

# ╔═╡ 7d55985c-2831-4718-aebe-cb825e1ed1d0
md"`-` 계산 2: 변수=함성함수"

# ╔═╡ 7028b921-8c1d-441c-9f15-8833ea5f7b5e
g=(x -> 3x) ∘ (x -> x+1)

# ╔═╡ 0a8998c0-6c17-4ac7-a52f-a28520927226
md"- g(x)=3(x+1)을 의미"

# ╔═╡ f67ba741-3329-48cf-aadc-025acfec6a76
g(3)

# ╔═╡ 4d85877b-2863-4f7c-a0f2-07cf30d01886
md"###### 추가학습 
함수 $f(x)=(x-1)^2$를 함성함수를 이용하여 선언하고 $(x,f(x))$의 그래프를 $x \in (-1,3)$의 범위에서 그린뒤에 제출 (단, x는 -1에서 시작하여 3으로 0.05간격의 벡터를 이용하여 생성한뒤에 그릴것)"

# ╔═╡ 1332c5c7-60a1-4833-a556-7bace5feb02a
@bind col ColorStringPicker()

# ╔═╡ a91f9c5e-bd0a-40cf-9048-375c4900ded2
k=Array((-1:0.05:3))

# ╔═╡ b2cacec4-5cc6-45ac-b7e0-32c1dd394d31
f(x)=(x -> x^2) ∘ (x -> x-1)

# ╔═╡ 20ab363b-0a97-408f-a6f1-c6a1183799aa
((x -> x^2) ∘ (x -> x-1))(1)

# ╔═╡ 3a0b7b8d-5ec1-42e0-b131-f16509247f90
f(1)

# ╔═╡ 0cac030a-73fe-4abf-9fe8-18619292e8b9
[f(x) for x in Array((-1:0.05:3))]

# ╔═╡ 3f2d9b7f-2b00-4603-8369-e64e290de550
plot(k,f(k),color=col)

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
# ╟─33a53520-a85e-11ec-13ad-ed6f43926530
# ╟─ef3b93d7-5087-4549-bd73-8eb05599b640
# ╟─f0fe7356-5c52-41b6-8716-a209aa04f881
# ╟─14db2de1-ae5b-4841-983f-60a4b3c3efc4
# ╟─4bbf5eed-30e1-4ad0-a6d8-d06deafa5c3a
# ╠═450f4303-45bc-4b81-88ac-84159cd8900c
# ╠═4fcc0de3-6144-4aa4-b738-35ad5e6a9e3b
# ╠═b36a4db1-2b2e-4f29-9bcb-438f8e381e7c
# ╟─c6af262b-1049-4767-95f7-5d14d4dd26c9
# ╠═e35b7c2a-7d0a-40ae-a5a9-43bda0a8e8c5
# ╟─32cf9baa-e900-48a9-b1af-79da69fbee38
# ╠═a3794873-9fda-4df3-bf76-4d00b75fa871
# ╟─af611b84-8e76-4718-99ad-7ddf8460fc62
# ╟─86985ca9-34a9-427c-a30f-8250105a4010
# ╠═d495fd29-4913-4fbc-b3a8-4b410db9fe0b
# ╟─33b7d35f-20cc-4b64-9955-54e1b2c48c6b
# ╠═8589a7a6-077a-4dfb-beae-1ff209d7d5c6
# ╟─19d23e35-d7a8-48c1-b153-bdd76b9cb622
# ╟─37cae432-0dfb-414f-9561-da633c9ed97e
# ╠═0b655f25-8ca8-4d64-bcee-58af417b6aca
# ╟─879e9e73-c1cb-42e3-8402-1dbbda23cf08
# ╠═d474e61b-7e87-496d-85d2-e1b357ae989d
# ╟─c19dd1ad-d767-4bed-8fd7-b4012b715614
# ╠═c13fe4bd-6ee9-4fe0-ad8f-9270d4a8d5c0
# ╟─c608b8b3-ca99-4834-ae80-d542e25c22a7
# ╟─24835818-0acc-4cce-875d-365b0e67e43b
# ╠═5166cde5-458a-43a1-a1f7-7f9d5a640ba2
# ╟─ff9315a5-2e3b-486d-87be-d18aa7c377ee
# ╠═53a76b3f-2767-41d0-8b98-9b93259af434
# ╟─7c52965b-292c-4fc9-a750-491c19a76a90
# ╠═25091216-3054-4cc8-aaad-97227e2fe8c7
# ╟─a9ec54d9-bd8b-4f9e-a80a-7d480c09570e
# ╟─27c80071-8551-45c3-bde7-c55e956101b4
# ╠═de247493-0b9a-41ad-959a-d005e0d36405
# ╠═ac937d1d-4cea-4988-87fb-f21f9db9e961
# ╟─ed5b239f-b26c-4118-ba86-43888fcc5352
# ╠═68230afe-fdf9-4c43-a4ba-04a739cc0398
# ╠═cf65c6ae-8fca-4389-ac76-b47aa2c976b0
# ╠═2ddf9e71-261e-4e8b-ac2b-e67a1c8a1205
# ╠═bb89b25a-fb41-403e-a30c-eeb6f909bd24
# ╠═56e720d8-0203-43ac-af39-097966c16619
# ╟─4089dd78-e459-4060-b415-f6e21ab9d6e3
# ╠═d57f0b9d-d22b-4529-a99a-59d7009b7a93
# ╠═7442010c-06e5-477c-8f05-1a9d03294901
# ╟─e06df9db-cd2f-4b41-8ac7-1966a3ee7fdd
# ╟─4c40caea-cd53-40c5-9eae-0e826ebf2117
# ╟─9f78c3bc-42e4-4e51-b0e6-ff2601d8720b
# ╠═a0571c3a-1218-4e13-9ed2-5c9d3ad2298e
# ╟─2b3fd404-a381-42e7-a778-0883eb6c5c72
# ╠═b43504c0-5026-4e7d-998d-f1aefef67536
# ╟─9bf1473b-e0c3-4610-885b-3cc612c19eca
# ╠═177ae1ba-e230-4931-b4a9-041bdf0bf012
# ╟─ea417c47-662e-488e-a7fc-5ce80e48b832
# ╠═1b02d3ce-5f4f-4ed2-b846-187292924ea7
# ╟─c76145c8-a5e0-4b71-bfa8-8774006fa092
# ╟─8966d471-4883-4b54-8e2e-27315ff09d39
# ╠═83d67ad5-3dee-4399-b359-16db76512d6a
# ╟─b30cc74a-af46-4201-981e-134f86941ff1
# ╠═3e3ed224-b9f0-4b5d-ad75-ab755da3eb51
# ╠═41f86a23-b4c8-4381-abbc-c9cc83a69dc3
# ╟─7de224a1-dd52-40a8-8cd6-656c7ef2d0fb
# ╠═f95e1bca-881b-4728-804d-788f91b5f44b
# ╟─e3c97fa5-432d-47ce-afc2-ad59a82932e5
# ╠═e029c2d7-f47a-45bf-8bac-0a4a911bc974
# ╠═df553080-c406-4497-a408-ab2437953f89
# ╟─729f4d42-3f5a-4bb4-ac4e-58ab70c2718f
# ╠═6b75f2dd-5ef2-40f0-af4d-c471540091fd
# ╠═8abaa9bf-f668-4684-88c7-b8b130a9a0c0
# ╠═2a33a664-a76e-4942-9b2a-9e3170d6188a
# ╠═387a1e14-def6-4e32-8d43-a0f809145ae5
# ╟─12a6c74c-b2f9-4fd1-bb01-3584d1e93431
# ╟─0d235e4a-0d34-4442-bed6-94f58c05018d
# ╠═8975240b-6b14-4d66-8b28-2f1cfcd417bd
# ╠═1a0a1e92-c8e6-443d-8fde-bb66ded09898
# ╠═699f0742-62ce-431d-b412-56cd6adef7cb
# ╠═88b25266-ca94-495f-a2d4-5d02872395d4
# ╟─cb9585a8-192c-4ab1-8c8c-376e8e7d66ae
# ╠═d69eb5c4-a221-4037-8cb0-7eb9c652df2a
# ╟─e51791ac-be42-4921-b563-e63d0b66a859
# ╠═89690f01-1bac-4169-b68f-4842dd0c8997
# ╠═e9bb456b-6dc7-4acd-86bc-24602d085d20
# ╟─988beb71-f9c1-4908-acd9-e07163251865
# ╠═e60ed9fb-9a7a-4606-a480-34bd9bbb3b1f
# ╠═568c72d8-ae56-4844-9124-5896774eafa1
# ╟─0f9eb977-3b3e-4303-881e-f8d4949c655c
# ╟─4b9dd218-646f-4236-8655-115544e5a4c8
# ╠═f84bf4fd-a0a5-4d53-9d35-8d3ecab5f08c
# ╠═ad7c4031-f0e5-4d78-aa52-c542814f73a6
# ╟─b0444597-c514-44d6-8b73-e6254471e067
# ╠═c942ca59-4f5c-43ad-82df-612503aa4796
# ╠═8a0d7fa1-e27f-4215-b41b-f70065b55e4f
# ╟─ffd03bbb-ed15-4eb1-913e-701031bf88d4
# ╟─0c58aa51-4c58-4ea8-b69a-3e9373079fdc
# ╠═9bca53ff-b63f-40a3-9d63-c704fceaa2c3
# ╠═9ad0e6d5-5fea-440b-b49a-7d2dc8a90c7a
# ╟─29b7109a-580d-47f0-b74f-07e2a80d0b9f
# ╠═a9e5a72a-5aa8-4793-8e8a-f9254bb12bd9
# ╠═7db1f547-c285-4864-9f09-6ebdd849cb4e
# ╟─2a99d6d0-c787-4d7c-a29f-5592cad60964
# ╟─efb04759-1ac7-4496-a778-5f3f0f953c12
# ╠═b53c9bf8-efdd-49a9-9e85-bfb47df7b1c7
# ╠═173ccdd7-454f-43df-8723-7af9633cf417
# ╠═e174f8e8-9514-4ba8-91d5-5c0a7315c6ce
# ╠═ca6330f0-5463-4786-854b-bc95e3a86203
# ╠═b13ab2d6-1bff-40b8-b2be-19f18cd44b38
# ╟─612bfc86-43f4-4467-aea7-cd1cec7ef11d
# ╟─2703c08c-9294-4c8f-99f6-75655d14c6c7
# ╠═68556616-54ca-4823-9415-5197980597ad
# ╠═c90f2710-b3dd-4457-af8d-f4dd3bc22e2d
# ╟─f32cd38f-43d1-41b5-9068-905e86a10d56
# ╠═1b1911a2-9e86-47dc-870f-86335da20565
# ╟─8eec5e28-ef90-46eb-bb56-4bdae4397274
# ╠═b9b1da61-788f-49ca-9910-2cc4de6062fb
# ╠═33c3eb29-3854-4e55-93b1-0750c005f351
# ╠═e622b92c-6898-4deb-b91c-8c7f62cb3dfe
# ╠═73cd9487-0ae7-4340-9588-9d1e26150212
# ╠═0e901426-2706-4fea-a05a-66066997885e
# ╠═0a4d8787-a78b-4f55-bca1-2c117eb58b62
# ╠═35f8b3bf-1f65-4f7e-bced-d82c69ddebd1
# ╠═47564629-530c-4d53-9bc3-f46a05a3b16b
# ╠═387bfdf3-a378-4e63-84ca-13dd25c92af7
# ╠═2b00902c-16d8-4c30-b200-6def0d62e806
# ╠═e8484aa7-f542-4735-93e4-b1d45ac68539
# ╠═0c5f907f-4f0e-4b53-872c-eb874e12e8a9
# ╠═97959485-027a-4d4d-9ec8-cdf29b9cf90e
# ╠═01dc10ee-3b59-4c96-a8ae-f23820a8dd0d
# ╠═4a475bae-639e-4d14-a70d-544e3b7b2b5d
# ╟─7ab7b939-b8f6-45ec-9237-42b45754dacf
# ╠═efeb5de8-a351-4007-bfe0-16b15e49e089
# ╟─fc13dba3-63b7-48cb-b8a3-b53cdc5efa8f
# ╠═9db0f80b-8e49-44dc-bf7b-1ea3177ad317
# ╠═c8ef1e64-e6ef-49a1-86ed-4b197ec17c5d
# ╠═d47d185a-eb61-40e8-b4ff-dbd111911d8f
# ╟─5cf760ad-b9c4-4209-93e6-e91edce2bd9e
# ╟─29aa5088-5751-45a6-b90b-b15b53d6d028
# ╠═5eb984af-a789-405c-b5ca-2d3975b539ed
# ╠═17aa70b1-522c-4138-a86d-7d9d488e1b8e
# ╟─aa0a539d-1efb-4246-af6d-261c7a39c6da
# ╠═c7f302f5-af1f-4c7b-baba-210e8b1a5518
# ╠═515fa5e0-b709-412c-a032-80fff1012527
# ╟─783a461e-e383-464c-a78e-487b0bd04955
# ╠═15cf0ac8-5fcc-40bf-81d4-ad8b87cc7d32
# ╠═51e1e257-93ab-48a0-bfe4-9ab44ac86ee1
# ╟─bb5dc061-4a72-4075-a50d-7440900d87da
# ╠═38d85648-31a9-4078-b373-9522ebd9f0a9
# ╠═e3ba7692-96e0-4959-99b6-f358cfee554a
# ╟─e8d5a0b6-feb2-44ac-8920-e4b980b2ab54
# ╠═d99b66fc-1d03-486b-8bcb-73559aa2a6ae
# ╠═7f3bf3f9-40ba-4894-871a-9517af0341d7
# ╟─109b6043-3ae6-4a90-a57f-8ea6bc6e8fdc
# ╠═7234f40d-a032-4e75-abe0-9225c23ff21f
# ╠═fdd07160-dc8e-4289-8ede-e0b460de906e
# ╟─c033b84b-8d9a-4a8c-9df2-5767a87ec8d7
# ╠═c25fbece-a5cc-4f67-b25e-1bc774c8e8dd
# ╟─c36029fd-f0a3-4cda-a6f6-1441bb68425c
# ╠═d3d58b6c-fcc5-4c67-8011-060c80102e4e
# ╠═930c0125-e7cf-4962-b953-cf58e15e947c
# ╟─de3830b0-8455-4bc4-88dc-2c2b62ec4600
# ╠═99cd5882-90f5-4f91-a458-2f1f603728d1
# ╟─8df7c994-8cab-4527-bccb-9640c76a13e0
# ╠═413b409e-4741-4cf0-bff1-8fdca171b400
# ╟─9f06cef0-5b2a-4d18-9323-b8c19855f37e
# ╠═8aae5504-e937-403a-a809-a4ba5c51d6e6
# ╟─7d55985c-2831-4718-aebe-cb825e1ed1d0
# ╠═7028b921-8c1d-441c-9f15-8833ea5f7b5e
# ╟─0a8998c0-6c17-4ac7-a52f-a28520927226
# ╠═f67ba741-3329-48cf-aadc-025acfec6a76
# ╟─4d85877b-2863-4f7c-a0f2-07cf30d01886
# ╠═156a5d9a-453a-49af-8dcd-891b4bf3d257
# ╠═83d2d2cb-de4b-401c-8e45-2f94929374ad
# ╠═1332c5c7-60a1-4833-a556-7bace5feb02a
# ╠═a91f9c5e-bd0a-40cf-9048-375c4900ded2
# ╠═b2cacec4-5cc6-45ac-b7e0-32c1dd394d31
# ╠═20ab363b-0a97-408f-a6f1-c6a1183799aa
# ╠═3a0b7b8d-5ec1-42e0-b131-f16509247f90
# ╠═0cac030a-73fe-4abf-9fe8-18619292e8b9
# ╠═3f2d9b7f-2b00-4603-8369-e64e290de550
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
