From: Zev Weiss <zev@bewilderbeest.net>
Date: Thu, 1 Apr 2021 20:19:47 -0500
Subject: [PATCH v3 4/4] dt-bindings: serial: 8250: add aspeed, lpc-address
 and aspeed,sirq
In-Reply-To: <639f957f-a0d7-4a06-8598-90da0e17820b@beta.fastmail.com>
References: <20210402004716.15961-1-zev@bewilderbeest.net>
 <20210402004716.15961-5-zev@bewilderbeest.net>
 <639f957f-a0d7-4a06-8598-90da0e17820b@beta.fastmail.com>
Message-ID: <YGZxM31x0All76gm@hatter.bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 01, 2021 at 08:14:39PM CDT, Andrew Jeffery wrote:
>
>
>On Fri, 2 Apr 2021, at 11:17, Zev Weiss wrote:
>> These correspond to the existing lpc_address, sirq, and sirq_polarity
>> sysfs attributes; the second element of aspeed,sirq provides a
>> replacement for the deprecated aspeed,sirq-polarity-sense property.
>>
>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>> ---
>>  .../devicetree/bindings/serial/8250.yaml      | 27 ++++++++++++++++---
>>  1 file changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml
>> b/Documentation/devicetree/bindings/serial/8250.yaml
>> index 491b9297432d..a6e01f9b745f 100644
>> --- a/Documentation/devicetree/bindings/serial/8250.yaml
>> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
>> @@ -12,8 +12,13 @@ maintainers:
>>  allOf:
>>    - $ref: /schemas/serial.yaml#
>>    - if:
>> -      required:
>> -        - aspeed,sirq-polarity-sense
>> +      anyOf:
>> +        - required:
>> +            - aspeed,lpc-address
>
>Why not aspeed,lpc-io-reg like the KCS binding?
>
>There are some things we can do to improve it, but we shouldn't go and invent something different. I prefer aspeed,lpc-io-reg because it's name derives from the generic 'reg' property as does it's behaviour (if you assume a related `#size-cells = 0`).
>
>> +        - required:
>> +            - aspeed,sirq
>
>Why not aspeed,lpc-interrupts like the KCS binding?
>
>The generic IRQ property is 'interrupts', so like aspeed,lpc-io-reg the interrupts proposal for KCS follows in name and form. I'm hiding it behind the aspeed vendor prefix for now while I'm not satisfied that I understand the requirements of non-aspeed parts. Similarly, I added the lpc prefix because we don't tend to describe the host devicetree in the BMC devicetree (and so there's no parent interrupt controller that we can reference via a phandle) and we need a way to differentiate from the local interrupts property.
>
>I don't see a reason for either of them to differ from what we already have for KCS, and I don't see any reason to continue the sysfs naming scheme in the binding.
>

Ah, OK -- I was aiming for consistency with the existing vuart sysfs 
attributes, but if that's not a worthwhile concern I'm fine with 
aspeed,lpc-io-reg & aspeed,lpc-interrupts.


Zev

