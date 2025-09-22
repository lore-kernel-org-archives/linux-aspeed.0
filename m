Return-Path: <linux-aspeed+bounces-2313-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EAFCAC5A8
	for <linux-aspeed@archiver.kernel.org>; Mon, 22 Sep 2025 14:36:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVlzG0Gtkz2yrr;
	Tue, 23 Sep 2025 00:36:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758551769;
	cv=none; b=mLgTvNt+F9OokaMUZzbkei+wJyWONXNAm+8rlFgFB5Pq7OSNnV321YbeohJNAIJIxtkEaswkI0XG0UTZ0Ky41bth9EQa6cckedOBoK7yRmd9UmPmgrPePi0xbxkrFbZBTG7bQg0VCLVk2gWcZQQtocl9Q3SwXY+mqVLr1GcoysaFf3HqOUk1jD0PrKep35IXLn6UnkELZzRbn3mHL3gR5aGhu+F3Uz31JrHXvmgXopvoTS3NrbcP2t2nd59mqo0rtIqyRiCCr8DXMIrQ/pfGB0+CkD1pn94k3QORCWVjbC9F4jnOuj3FC3l9uSzXaQBRyB5aWAx70fiZuPqL3ebeqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758551769; c=relaxed/relaxed;
	bh=mO3ogg0t3lyC9fJ75KZxSFYoxkvUJ3UjtYdnY1N//jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PB7CsAXUQkcltvRRawTfPyKLgRluJhNHO9khSDHHZY2WKyX/rVuri5XpUKM+AZLdcM2FgcvEkWfbi4+WnqwDjpluD1MSt7Wc1ZeY71VSjomQ/zegfSRVilrg9pSzXweWg4uN/B1ZlzmNNru9wffJLyL0BxN9F1g1oOvMSJ6m0Up7WbdK3NDs/XphTaXv+B2L7BSVMl4N1/VikHbUYsU4im1BJDSzFmW8aQsR2E0zJnYqCSuRGv2mSb4KWiNVXeb79lsP4T7XjjqTFv2E8d4Q3J0kbAZJBFFVXTAkEx8EXcx6TER7dq40M+R6syeoIPBdxh0hwq5D2PmrhFsYQcurbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=okjHR2j+; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=okjHR2j+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVlzF13s0z2yr1
	for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Sep 2025 00:36:08 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8MUWf027669;
	Mon, 22 Sep 2025 14:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mO3ogg
	0t3lyC9fJ75KZxSFYoxkvUJ3UjtYdnY1N//jI=; b=okjHR2j+ZheBMRTP8UUN1j
	LAjTU9EgX1fl1HkZwHFezao8tl0mVKdg/IQ/8BO/ayWU+XF1Jn3OrpeuYQByV8jT
	1AHNBpZOEzWWccmxz2hqKHFPKmtUcx51GOeovrYldax7rPZ80nDD6pPz77qCEFgf
	CiEaKWSzeQn2Oru0uvZ9v28dZ8ehKX/VUD2ethhqDh0UVDjh7AkwBnL0LnypunAt
	nSLPF5bpP+93E1EON+MWXu1xxE5uEyspJ05cSep8sO1zDOUJzfy8TJRWEhLJkKhP
	KXQrjh3TzQ0BGD69/jChUQ2BfBPNWz5epVzHR/Y3VLaZ7AfP3uT/1pHN6Ob7pxNA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ksbkj07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 14:35:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58MCCWFL008294;
	Mon, 22 Sep 2025 14:35:52 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a6yxpqfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 14:35:52 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58MEZqn450397578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 14:35:52 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16F3958043;
	Mon, 22 Sep 2025 14:35:52 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C450A58055;
	Mon, 22 Sep 2025 14:35:51 +0000 (GMT)
Received: from [9.61.160.40] (unknown [9.61.160.40])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Sep 2025 14:35:51 +0000 (GMT)
Message-ID: <ce501b21-5aa5-46aa-bf2d-7d81fe127b03@linux.ibm.com>
Date: Mon, 22 Sep 2025 09:35:51 -0500
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] ARM: dts: aspeed: Add Balcones system
To: Rob Herring <robh@kernel.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, krzk+dt@kernel.org,
        andrew@codeconstruct.com.au
References: <20250918180402.199373-1-eajames@linux.ibm.com>
 <175823464696.3104136.904298221604133111.robh@kernel.org>
 <20250918225941.GA3127900-robh@kernel.org>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20250918225941.GA3127900-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TQPLF1yrSuOl3rty7ohAc0kphBAAWlV8
X-Proofpoint-GUID: TQPLF1yrSuOl3rty7ohAc0kphBAAWlV8
X-Authority-Analysis: v=2.4 cv=SdH3duRu c=1 sm=1 tr=0 ts=68d15eca cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=gEfo2CItAAAA:8 a=VnNF1IyMAAAA:8
 a=3qCSxU--W8Qv9TwLQ9sA:9 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfX4XlnKT9L8pOz
 BM96Cj6cemt/EgSrq+9YeM+5FprLxcKu2SGIuPNo0wsuKc+LKyxKeNc/4Vg4AWMLlnlG4jkPAZo
 fJrJA8kr+ftHmWnIb0ClOumJGJWXwxRw0jgeQulA0nNzZUPlG3rEDs0pWNZVBtroOmCMH8cr2y+
 agCinYa2sA9+7KKQRwfbCjziBcx5mCDVcL+o63YfXrhqoM+BPqe7gosc1WDjq+h390gSI4dJk3h
 ujjXfJJwg6IN2k7CWvys/JKTmfKKtdoCAXocmYOtpOsRaXSoBa0P7nPJl29FZDOFx/mQaO4vMcQ
 SN51ynAkngnxHaiwhFKMOpqGmrveELFk+Z2NMtjqTkH6QZZ4FUrFz7wQ2ZGT/8fij+4rO+qMUdb
 KmQHQiJV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020


On 9/18/25 5:59 PM, Rob Herring wrote:
> On Thu, Sep 18, 2025 at 05:33:06PM -0500, Rob Herring (Arm) wrote:
>> On Thu, 18 Sep 2025 13:03:55 -0500, Eddie James wrote:
>>> The Balcones system is similar to Bonnell but with a POWER11 processor.
>>>
>>> Changes since v5:
>>>   - Add patch to add address and size cells to max31790 document
>>>   - Don't remove address and size cells in max31785 fixes change
>>>
>>> Changes since v4:
>>>   - Add patch to fix max31785 warnings
>>>   - Add patch to fix missing Bonnell documentation
>>>
>>> Changes since v3:
>>>   - Add max31785 to the max31790 document instead of to trivial-devices
>>>   - Fix minor formatting in dps310 document
>>>
>>> Changes since v2:
>>>   - Fix a couple of incorrect i2c addresses
>>>   - Document dps310 and max31785 properly
>>>   - Drop the UCD binding documentation update, it's been fixed
>>>
>>> Changes since v1:
>>>   - Add all the ucd9000 driver supported compatible strings
>>>   - Fix node ordering in Balcones device tree
>>>   - Improve commit message to explain addition of ibm-power11-dual.dtsi
>>>
>>> Eddie James (7):
>>>    dt-bindings: arm: aspeed: add IBM Balcones board
>>>    dt-bindings: arm: aspeed: add IBM Bonnell board
>>>    dt-bindings: iio: Add Infineon DPS310 sensor documentation
>>>    dt-bindings: hwmon: Move max31785 compatibles to max31790 document
>>>    dt-bindings: hwmon: max31790: Document address and size cells
>>>    ARM: dts: aspeed: Add Balcones system
>>>    ARM: dts: aspeed: Fix max31785 fan node naming
>>>
>>>   .../bindings/arm/aspeed/aspeed.yaml           |   2 +
>>>   .../devicetree/bindings/hwmon/max31785.txt    |  22 -
>>>   .../bindings/hwmon/maxim,max31790.yaml        |  12 +-
>>>   .../iio/pressure/infineon,dps310.yaml         |  44 +
>>>   .../devicetree/bindings/trivial-devices.yaml  |   2 -
>>>   MAINTAINERS                                   |   1 +
>>>   arch/arm/boot/dts/aspeed/Makefile             |   1 +
>>>   .../dts/aspeed/aspeed-bmc-ibm-balcones.dts    | 609 ++++++++++++++
>>>   .../dts/aspeed/aspeed-bmc-ibm-bonnell.dts     |   4 +-
>>>   .../dts/aspeed/aspeed-bmc-ibm-everest.dts     |   8 +-
>>>   .../dts/aspeed/aspeed-bmc-ibm-rainier.dts     |  12 +-
>>>   .../boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts |   8 +-
>>>   .../arm/boot/dts/aspeed/ibm-power11-dual.dtsi | 779 ++++++++++++++++++
>>>   .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 769 +----------------
>>>   14 files changed, 1465 insertions(+), 808 deletions(-)
>>>   delete mode 100644 Documentation/devicetree/bindings/hwmon/max31785.txt
>>>   create mode 100644 Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
>>>   create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts
>>>   create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi
>>>
>>> --
>>> 2.51.0
>>>
>>>
>>>
>>
>> My bot found new DTB warnings on the .dts files added or changed in this
>> series.
>>
>> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
>> are fixed by another series. Ultimately, it is up to the platform
>> maintainer whether these warnings are acceptable or not. No need to reply
>> unless the platform maintainer has comments.
>>
>> If you already ran DT checks and didn't see these error(s), then
>> make sure dt-schema is up to date:
>>
>>    pip3 install dtschema --upgrade
>>
>>
>> This patch series was applied (using b4) to base:
>>   Base: attempting to guess base-commit...
>>   Base: tags/next-20250917 (best guess, 10/11 blobs matched)
>>
>> If this is not the correct base, please add 'base-commit' tag
>> (or use b4 which does this automatically)
>>
>> New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250918180402.199373-1-eajames@linux.ibm.com:
>>
>> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: timer (arm,armv7-timer): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
>> 	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
>> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /sdram@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac', 'syscon']
>> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: bus@1e600000 (aspeed,ast2600-ahbc): compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
>> 	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
>> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: syscon@1e6e2000 (aspeed,ast2600-scu): 'smp-memram@180' does not match any of the regexes: '^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^pinctrl-[0-9]+$', '^silicon-id@[0-9a-f]+$'
>> 	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
>> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: max31785@52 (maxim,max31785a): fan-0: Unevaluated properties are not allowed ('compatible', 'maxim,fan-dual-tach', 'maxim,fan-fault-pin-mon', 'maxim,fan-no-fault-ramp', 'maxim,fan-no-watchdog', 'maxim,fan-pwm-freq', 'maxim,fan-ramp', 'maxim,fan-rotor-input', 'tach-pulses' were unexpected)
>> 	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
>> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: max31785@52 (maxim,max31785a): fan-1: Unevaluated properties are not allowed ('compatible', 'maxim,fan-dual-tach', 'maxim,fan-fault-pin-mon', 'maxim,fan-no-fault-ramp', 'maxim,fan-no-watchdog', 'maxim,fan-pwm-freq', 'maxim,fan-ramp', 'maxim,fan-rotor-input', 'tach-pulses' were unexpected)
>> 	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
>> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: max31785@52 (maxim,max31785a): fan-2: Unevaluated properties are not allowed ('compatible', 'maxim,fan-dual-tach', 'maxim,fan-fault-pin-mon', 'maxim,fan-no-fault-ramp', 'maxim,fan-no-watchdog', 'maxim,fan-pwm-freq', 'maxim,fan-ramp', 'maxim,fan-rotor-input', 'tach-pulses' were unexpected)
>> 	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
>> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: max31785@52 (maxim,max31785a): fan-3: Unevaluated properties are not allowed ('compatible', 'maxim,fan-dual-tach', 'maxim,fan-fault-pin-mon', 'maxim,fan-no-fault-ramp', 'maxim,fan-no-watchdog', 'maxim,fan-pwm-freq', 'maxim,fan-ramp', 'maxim,fan-rotor-input', 'tach-pulses' were unexpected)
>> 	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
>> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: /ahb/apb/bus@1e78a000/i2c@200/max31785@52/fan-0: failed to match any schema with compatible: ['pmbus-fan']
>> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: /ahb/apb/bus@1e78a000/i2c@200/max31785@52/fan-1: failed to match any schema with compatible: ['pmbus-fan']
>> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: /ahb/apb/bus@1e78a000/i2c@200/max31785@52/fan-2: failed to match any schema with compatible: ['pmbus-fan']
>> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: /ahb/apb/bus@1e78a000/i2c@200/max31785@52/fan-3: failed to match any schema with compatible: ['pmbus-fan']
> Sigh. Are you testing this before sending?


Yes, but I wasn't sure if this was better or worse than before! These 
same kind of warnings show up without my changes, but since the node 
names are different, they show up in your list of new warnings.

Anyway I didn't realize it was allowable to do fan@ at all; I can add a 
pattern property in max documentation for that. And I left the maxim 
properties because I'd argue it's out of the scope of this change, but I 
can go ahead and remove them.


Thanks, and sorry for the churn.

Eddie


>
> None of these "maxim" properties are documented nor used by any driver.
> I don't know what a 'pmbus-fan' is as it is not documented.
>
> For the fan child nodes and their node names, it is quite simple. You
> have 2 options:
>
> fan-[0-9]+:
> - no reg property
> - no #address-cells or #size-cells in the parent node
>
> fan@[0-9a-f]:
> - must have reg property
> - must have #address-cells or #size-cells in the parent node
>
> If the parent device has a concept of fan channels (perhaps pages as
> the driver calls them?), then you should use 'reg' to map the fan
> channels to child nodes. For some fan controllers, 'reg' corresponds
> to the PWM number or pin number. Node names are generally not considered
> ABI, so you shouldn't be using them at all. That means the "fan-[0-9]+"
> case has no mapping between the fan node and instances in the fan
> controller.
>
> Rob

