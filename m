From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 24 Jun 2022 09:12:04 +0200
Subject: (subset) [PATCH 7/7] ARM: dts: aspeed: centriq2400: use qcom
 compatible
In-Reply-To: <84cba0c8-fb31-3314-5e2c-7a0c13030b9a@linaro.org>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
 <20220529104928.79636-7-krzysztof.kozlowski@linaro.org>
 <165589305701.29629.10216921074802952879.b4-ty@linaro.org>
 <CACPK8XfxXi8kQr+vxta8rD6SBgxLf_oBjAH0UkPBacQta552YQ@mail.gmail.com>
 <84cba0c8-fb31-3314-5e2c-7a0c13030b9a@linaro.org>
Message-ID: <0378a9e1-a2f9-5c7d-2fdd-0a78ff237db9@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 23/06/2022 09:05, Krzysztof Kozlowski wrote:
> On 23/06/2022 07:34, Joel Stanley wrote:
>> On Wed, 22 Jun 2022 at 10:17, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On Sun, 29 May 2022 12:49:28 +0200, Krzysztof Kozlowski wrote:
>>>> "qualcomm" is not a documented compatible and instead "qcom" should be
>>>> used.
>>>>
>>>>
>>>
>>> Applied, thanks!
>>
>> What tree did you apply this to? Did you get review from the maintainer?
> 
> Tree was mentioned below.
> 
>>
>> This board is unmaintained and unused. I would prefer it removed
>> rather than meaningless fixes be applied.
> 
> I can drop the patch. I'll send the patch to remove the board.

Does your answer also means that you are planning to take these? I am
going to prepare a pull request to arm-soc so need to know whether to
keep these or not. I don't have any particular need of handling these
patches by myself, but I want the issues to get fixed.

Best regards,
Krzysztof
