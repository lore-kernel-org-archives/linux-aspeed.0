From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 4 Apr 2024 08:13:05 +0200
Subject: [PATCH 1/4] ARM: dts: aspeed: greatlakes: correct Mellanox
 multi-host property
In-Reply-To: <8610e0a8aa5c2916fa04292a10e8a843862ff0ee.camel@codeconstruct.com.au>
References: <20231209104412.12916-1-krzysztof.kozlowski@linaro.org>
 <171213860535.16780.4635499105199545058.b4-ty@linaro.org>
 <8610e0a8aa5c2916fa04292a10e8a843862ff0ee.camel@codeconstruct.com.au>
Message-ID: <c3902c6e-c38e-4604-b79e-2b5406274d8f@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 04/04/2024 03:41, Andrew Jeffery wrote:
> On Wed, 2024-04-03 at 12:04 +0200, Krzysztof Kozlowski wrote:
>> On Sat, 09 Dec 2023 11:44:09 +0100, Krzysztof Kozlowski wrote:
>>> "mlx,multi-host" is using incorrect vendor prefix and is not documented.
>>>
>>>
>>
>> These wait for ~4 months and they were not picked up. Let me know if anyone
>> else wants to take these.
>>
>> Applied, thanks!
>>
>> [1/4] ARM: dts: aspeed: greatlakes: correct Mellanox multi-host property
>>       https://git.kernel.org/krzk/linux-dt/c/7da85354c4fa35b862294dbbb450baeb405b5a92
>> [2/4] ARM: dts: aspeed: minerva-cmc: correct Mellanox multi-host property
>>       https://git.kernel.org/krzk/linux-dt/c/e515719c17beb9625a90039f6c45fa36d58bdda2
>> [3/4] ARM: dts: aspeed: yosemite4: correct Mellanox multi-host property
>>       https://git.kernel.org/krzk/linux-dt/c/af3deaf9bcb4571feb89a4050c7ad75de9aa8e1e
>> [4/4] ARM: dts: aspeed: yosemitev2: correct Mellanox multi-host property
>>       https://git.kernel.org/krzk/linux-dt/c/cac1c1dda6130771e06ace030b1b0ed62096a912
>>
>> Best regards,
> 
> Ah, my apologies. Joel's on leave and I'm accumulating patches in a
> tree for him in the mean time. I've had some things going on
> professionally (changed jobs) and personally, and these fell into a bit
> of a hole.
> 
> I'm okay for these patches to be integrated through your tree, given
> you've already applied them. Feel free to add acks if your branch
> allows:
> 
> Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> 
> I'm working to stay on top of things a bit more now than I have in the
> recent past, so hopefully I won't miss patches again in the future.

Stephen reported conflict, although trivial, but maybe better if you
take them? I can rebase and resend.

Best regards,
Krzysztof

