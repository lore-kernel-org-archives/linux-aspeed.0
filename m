From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 21 Jul 2022 17:36:17 +0200
Subject: [PATCH 1/6] ARM: refresh defconfig files
In-Reply-To: <9321ce6c-7565-a7eb-2bfe-dac144ab7733@broadcom.com>
References: <20220721141325.2413920-1-arnd@kernel.org>
 <20220721141325.2413920-2-arnd@kernel.org>
 <9321ce6c-7565-a7eb-2bfe-dac144ab7733@broadcom.com>
Message-ID: <9e872a00-966a-aaf8-7bb9-6627fcb0cf83@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21/07/2022 17:33, Scott Branden wrote:
> Hi Arnd,
> 
> On 2022-07-21 07:13, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> A lot of Kconfig options have changed over the years, and we tend
>> to not do a blind 'make defconfig' to refresh the files, to ensure
>> we catch options that should not have gone away.
>>
>> I used some a bit of scripting to only rework the bits where an
>> option moved around in any of the defconfig files, without also
>> dropping any of the other lines, to make it clearer which options
>> we no longer have.
> Resync is fine.  But, it would be great if the defconfig files were kept 
> in sync. Almost every kernel version kconfig options change which affect 
> these files. Could we put in place a defconfig refresh per kernel 
> version to keep them all in sync going forward?
>

Not entirely, because some Kconfig changes are causing symbols to
disappear. Also defconfig is expected to include user-visible options,
even if savedefconfig would drop them.

This is why blind savedefconfig is not acceptable.

Best regards,
Krzysztof
