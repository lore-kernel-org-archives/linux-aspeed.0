From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 23 Jun 2022 09:05:37 +0200
Subject: (subset) [PATCH 7/7] ARM: dts: aspeed: centriq2400: use qcom
 compatible
In-Reply-To: <CACPK8XfxXi8kQr+vxta8rD6SBgxLf_oBjAH0UkPBacQta552YQ@mail.gmail.com>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
 <20220529104928.79636-7-krzysztof.kozlowski@linaro.org>
 <165589305701.29629.10216921074802952879.b4-ty@linaro.org>
 <CACPK8XfxXi8kQr+vxta8rD6SBgxLf_oBjAH0UkPBacQta552YQ@mail.gmail.com>
Message-ID: <84cba0c8-fb31-3314-5e2c-7a0c13030b9a@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 23/06/2022 07:34, Joel Stanley wrote:
> On Wed, 22 Jun 2022 at 10:17, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On Sun, 29 May 2022 12:49:28 +0200, Krzysztof Kozlowski wrote:
>>> "qualcomm" is not a documented compatible and instead "qcom" should be
>>> used.
>>>
>>>
>>
>> Applied, thanks!
> 
> What tree did you apply this to? Did you get review from the maintainer?

Tree was mentioned below.

> 
> This board is unmaintained and unused. I would prefer it removed
> rather than meaningless fixes be applied.

I can drop the patch. I'll send the patch to remove the board.

> 
>>
>> [7/7] ARM: dts: aspeed: centriq2400: use qcom compatible
>>       https://git.kernel.org/krzk/linux/c/6202c6063145cf9ec22b40aac219122dd702a10f
>>
>> Best regards,
>> --
>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
