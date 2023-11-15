From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 15 Nov 2023 13:13:56 +0100
Subject: [PATCH 2/2] ARM: dts: aspeed: Add ASRock E3C256D4I BMC
In-Reply-To: <b06b2b9e-8185-41e8-89b5-e6bc8d09d948@hatter.bewilderbeest.net>
References: <20231114112722.28506-4-zev@bewilderbeest.net>
 <20231114112722.28506-6-zev@bewilderbeest.net>
 <cde26249-1d47-496f-b198-a0c4c02bed5c@linaro.org>
 <b06b2b9e-8185-41e8-89b5-e6bc8d09d948@hatter.bewilderbeest.net>
Message-ID: <6bb81878-2b68-4721-86c0-5f6eaec59434@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 14/11/2023 23:21, Zev Weiss wrote:

>> It does not look like you tested the DTS against bindings. Please run
>> `make dtbs_check W=1` (see
>> Documentation/devicetree/bindings/writing-schema.rst or
>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
>> for instructions).
>>
> 
> Au contraire -- I did, and it exited 0 with no output, which I 
> interpreted as a clean pass.  Are there particular shortcomings beside 
> what you've already pointed out that you would have expected it to flag?

Then paste entire command result here, including the command you used.

Best regards,
Krzysztof

