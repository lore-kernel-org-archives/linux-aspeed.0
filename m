From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 27 Jun 2022 16:44:43 +0700
Subject: [PATCH] ARM: dts: aspeed: Add device tree for Ampere's Mt.
 Mitchell BMC
In-Reply-To: <aafd58d6-8705-96ee-7813-9b3bae7bb3d1@linaro.org>
References: <20220621092120.2427152-1-quan@os.amperecomputing.com>
 <97934f38-4da5-ab9e-7089-d6e48edd5e6a@linaro.org>
 <9120c167-38c2-f8c4-e039-4202d5844639@os.amperecomputing.com>
 <aafd58d6-8705-96ee-7813-9b3bae7bb3d1@linaro.org>
Message-ID: <624cd43b-af83-402d-86bb-68e7242da0f7@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 27/06/2022 16:35, Krzysztof Kozlowski wrote:
> On 27/06/2022 11:32, Quan Nguyen wrote:
>>>> +
>>>> +	ltc2497_reg: ltc2497_regulator {
>>>
>>> No underscores in node name, no specific names (Devicetree spec requires
>>> generic), so ltc2497 has to go. You could add some more specific
>>> prefix/suffix to describe the function.
>>>
>> This is to monitor peripheral voltage so it would be updated to:
> 
> But it is a regulator, not a voltage monitor, so the node name could be:
> regulator-0
> regulator-voltage-mon
> voltage-mon-regulator
> 
Yes, I think I would pick the voltage-mon-regulator:

            voltage_mon_reg: voltage-mon-monitor {

>>
>>            voltage_monitor: voltage-monitor {
>>
>>>> +		compatible = "regulator-fixed";
>>>> +		regulator-name = "ltc2497_reg";
>>>> +		regulator-min-microvolt = <3300000>;
>>>> +		regulator-max-microvolt = <3300000>;
>>>> +		regulator-always-on;
>>>> +	};
>>>> +
> 
> 
Thanks a lot for the quick suggestion.
- Quan

