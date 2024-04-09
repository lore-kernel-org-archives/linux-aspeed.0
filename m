From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 09 Apr 2024 08:53:03 -0000
Subject: [PATCH 3/9] dt-bindings: rtc: lpc32xx-rtc: move to trivial-rtc
In-Reply-To: <dd5e9837-0dcf-4b0e-8d11-f8bed868cdf2@linaro.org>
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
 <20240408-rtc_dtschema-v1-3-c447542fc362@gmail.com>
 <dd5e9837-0dcf-4b0e-8d11-f8bed868cdf2@linaro.org>
Message-ID: <6dc808bf-682f-4e91-aac7-7ce6f05a0ab4@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 4/9/24 09:34, Krzysztof Kozlowski wrote:
> On 08/04/2024 17:53, Javier Carrasco wrote:
>> This RTC requires a compatible, a reg and a single interrupt,
>> which makes it suitable for a direct conversion into trivial-rtc.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt  | 15 ---------------
>>  Documentation/devicetree/bindings/rtc/trivial-rtc.yaml |  2 ++
>>  2 files changed, 2 insertions(+), 15 deletions(-)
> 
> This one no... and if you tested DTS you would see errors, although you
> need to test specific lpc config, not multi_v7.
> 
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
> 
> Anyway, you *must* check all DTS before moving anything to trivial.
> 
> Does it mean all other bindings were not checked against DTS at all?
> 
> Best regards,
> Krzysztof
> 
Hi,

I did check the conversion against nxp/lpc/lpc3250-phy3250.dts, which
throws a message about the 'clocks' property.

That property is not documented in the original binding, and even though
it could be missing, I could not find any function to get a clock (i.e.
any form of clk_get()) in rtc-lpc32xx.c, which is the only file where
the compatible can be found.

Is therefore the property not useless in the dts? My apologies if I am
missing something here.

Thanks and best regards,
Javier Carrasco
