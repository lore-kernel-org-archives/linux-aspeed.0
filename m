From: Ninad Palsule <ninad@linux.ibm.com>
Date: Tue, 9 Jan 2024 17:36:05 -0600
Subject: [PATCH v2 3/3] ARM: dts: aspeed: System1: IBM system1 BMC board
In-Reply-To: <b09d6e54-66e9-482f-8f45-38381fa6b62e@sirena.org.uk>
References: <20240108204114.1041390-1-ninad@linux.ibm.com>
 <20240108204114.1041390-4-ninad@linux.ibm.com>
 <b09d6e54-66e9-482f-8f45-38381fa6b62e@sirena.org.uk>
Message-ID: <aeabec28-a3a8-4ce1-b95b-a548cd27d626@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Mark,

On 1/8/24 15:34, Mark Brown wrote:
> On Mon, Jan 08, 2024 at 02:41:14PM -0600, Ninad Palsule wrote:
>
>> +	regulator at 60 {
>> +		compatible = "maxim,max8952";
>> +		reg = <0x60>;
>> +
>> +		max8952,default-mode = <0>;
>> +		max8952,dvs-mode-microvolt = <1250000>, <1200000>,
>> +						<1050000>, <950000>;
>> +		max8952,sync-freq = <0>;
>> +		max8952,ramp-speed = <0>;
>> +
>> +		regulator-name = "VR_1.0V";
>> +		regulator-min-microvolt = <770000>;
>> +		regulator-max-microvolt = <1400000>;
> A regulator labelled VR_1.0V can vary between 0.77V and 1.4V and has
> exactly the same configuration as another regulator labelled VR_1.2V?
> That seems...  odd?

That was a typo. I fixed it.

Thanks for the review.

Regards,

Ninad

