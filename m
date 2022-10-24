From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 24 Oct 2022 12:03:27 -0700
Subject: [PATCH 2/2] dt-bindings: watchdog: aspeed: Document
 aspeed,pre-timeout-irq-us
In-Reply-To: <20221024184423.GA2023764-robh@kernel.org>
References: <20221021151559.781983-1-eajames@linux.ibm.com>
 <20221021151559.781983-3-eajames@linux.ibm.com>
 <20221024184423.GA2023764-robh@kernel.org>
Message-ID: <31046e78-840f-4c1a-3966-6cb539e11685@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/24/22 11:44, Rob Herring wrote:
> On Fri, Oct 21, 2022 at 10:15:59AM -0500, Eddie James wrote:
>> Document this new property for the pre-timeout interrupt.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>> index a8197632d6d2..81d2c35ca7e3 100644
>> --- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>> @@ -40,12 +40,17 @@ Optional properties:
>>   			specified no external signal is sent.
>>    - aspeed,ext-pulse-duration: External signal pulse duration in microseconds
>>   
>> -Optional properties for AST2500-compatible watchdogs:
>> +Optional properties for AST2500 and AST2600 compatible watchdogs:
>>    - aspeed,ext-push-pull: If aspeed,external-signal is present, set the pin's
>>   			 drive type to push-pull. The default is open-drain.
>>    - aspeed,ext-active-high: If aspeed,external-signal is present and and the pin
>>   			   is configured as push-pull, then set the pulse
>>   			   polarity to active-high. The default is active-low.
>> + - aspeed,pre-timeout-irq-us: If aspeed,pre-timeout-irq-us is non-zero, the
>> +			      pre-timeout interrupt will be enabled for the
>> +			      watchdog. The interrupt will fire the specified
>> +			      number of microseconds before the watchdog expires
>> +			      and trigger a kernel panic.
> 
> A pre-timeout interrupt is fairly common. Come up with a common property
> please. You'll need to be clear if the time is from wdog restart or time
> before final timeout.
> 

It would be nice if it would match the semantics of the existing
pretimeout attribute in the watchdog core.

Guenter

