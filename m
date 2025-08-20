Return-Path: <linux-aspeed+bounces-2006-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA35FCA0EE4
	for <linux-aspeed@archiver.kernel.org>; Wed, 20 Aug 2025 19:40:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6cHb6jh1z300M;
	Thu, 21 Aug 2025 05:40:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755718827;
	cv=none; b=dWfM9KfLSO/GmsswfmAmQtEljeNt556/r7pScYlexbfeUvTx300o3WjMzMv2dC5QwlVJaAWmbF3ohlpb3JuYHR6XDAIjut/RdnazFvezKEgXhvN98T2ZSdg03rC+ByOnsCv0oRxwnz5bn0IKnS1ShtKCFXC9NN8HVPVGZ/IQuBWttVEK08wlh4CyBIJ4UTVUKK0c1gZMNgUwbNxUyKcHWjU+MTDOTcmiOzcA9S/74weCcEPjkIGmQlEN3gcNoO/2Ull7xWeOSSuuvWc4F4t756cQzt9ra2AJUPvmEs2GTW1Prw3r+koThP1Nh91WbKRpjZlNokmsXWwCP/6Ap/z/eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755718827; c=relaxed/relaxed;
	bh=9/KVphgfiv6IwABh1dktxL7uQw8uHuB00Gx8L/er2GQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3HIxUB3zok9cU/wbu4Zl0uKRUO4SiZbZ4KdXaacrO2/LCVeekKx79s1P3cTVEVy1Xpf1TJVIqmHuOtGxzeOb0tNF6t8V4VPuYrlPfj6haNJ4lmakrXYX7YFytlDEwz0Ne3DD0cChjJjM6mQ4G9940X92kZDgxgVZ6nqQ9NuW5gc5fwzusFNVjw4EpEqVKxrPRSH9Ko71LrfMYQN43hzkosMLcVlATWJlVG2VkHijxTqmMv2YiMrLI142BU4MjDtbOcQmZtTDPW3QnO2D01TQNBwMpoK1f8tPVvwKFV7ESCrfrpnmeRiwTwy7TOfcNFBQ7l83aQR4MSDGoXGL4kDvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i6mqZjP1; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i6mqZjP1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6cHZ5y1tz2yZ6
	for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Aug 2025 05:40:26 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KJPjAJ027437;
	Wed, 20 Aug 2025 19:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9/KVph
	gfiv6IwABh1dktxL7uQw8uHuB00Gx8L/er2GQ=; b=i6mqZjP18rMHSwwBr6UgkT
	Ty4StOalb2IsaGlX2Vg3iTEeu0++pOTX9NJa8Fp7T1h1tT6bFopii2N6Id86/kb2
	hqJrePPREFpQC9hv/dzTv0vIJ+/PHwZw/qghsUHHhEa3Z86I2+eXxDgYZjCidZqf
	ePWdrB1aREks7Bx1iW0sdjmyMUwDko1RKKPnt7+9lMgPXegztGXwBtFimBG5H7lC
	zYvL27J/Qi+g0O7oZQoTYY+yHWwlOdGn7/L5bo71r4Fv6mBf6lBp3kVMjUmjTtrn
	pjXGeEatSEWxnMrW50Mu83eNbK9oWz/wMvwi0x4Mkq0tVARH8GwzNQsUBBqaPSPw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vd01s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 19:40:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57KHUgte015619;
	Wed, 20 Aug 2025 19:40:16 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my424wcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 19:40:16 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57KJeGmV29491724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 19:40:16 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECCB958043;
	Wed, 20 Aug 2025 19:40:15 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A19258059;
	Wed, 20 Aug 2025 19:40:15 +0000 (GMT)
Received: from [9.61.87.76] (unknown [9.61.87.76])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Aug 2025 19:40:15 +0000 (GMT)
Message-ID: <f366aedf-0231-43f1-8416-994ca4b91342@linux.ibm.com>
Date: Wed, 20 Aug 2025 14:40:15 -0500
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
Subject: Re: [PATCH v4 0/4] ARM: dts: aspeed: Add Balcones system
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-aspeed@lists.ozlabs.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, andrew@codeconstruct.com.au,
        krzk+dt@kernel.org
References: <20250815194730.41695-1-eajames@linux.ibm.com>
 <175530106096.3523003.10423924922951806073.robh@kernel.org>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <175530106096.3523003.10423924922951806073.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfXxovrEBVRkjcE
 6LrcuSAdP1xnLVrJMmnPHeG09rdK7TnLxHfbKc9AxNsGCE288WQTRsSBHDD4eeffsPUcKKSo+EW
 /a7zqJBqawkxaBsZRGDhkuvyPvBflSamIrJq0Jjxor0Ox5dpMVhDjQkDqjexr9OLWl109HtdvnF
 NWefepUmyUj6w5OxT07+auXe/UbKMYJeEkKbROEjSWWosFviiyyo7gclqL/ZWLEiumAWDrwfrM5
 8G5tWWJxisyQiYZoHn6m4inlE/81l9ERH7EWevWJQH6xjUSSfg2v/+Y4Ygg3uBfjwm9feVFZn55
 okxUNZaMKXhFaXwW0pafvmFPOuJJBo6bO4oPmtsC8F9VSlLZai6HcEgDLUVh/hHO/FBzGdLfRUO
 7EDowsrx7hPeYJK+8SvIEgIBb1cL7Q==
X-Authority-Analysis: v=2.4 cv=PMlWOfqC c=1 sm=1 tr=0 ts=68a624a1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=VnNF1IyMAAAA:8
 a=ii2Ap2AerDCMVg_UhdYA:9 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 1d5YrVc__SnDGy5PXZyIItfcX5WxeyY-
X-Proofpoint-ORIG-GUID: 1d5YrVc__SnDGy5PXZyIItfcX5WxeyY-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222


On 8/15/25 6:38 PM, Rob Herring (Arm) wrote:
> On Fri, 15 Aug 2025 14:47:26 -0500, Eddie James wrote:
>> The Balcones system is similar to Bonnell but with a POWER11 processor.
>>
>> Changes since v3:
>>   - Add max31785 to the max31790 document instead of to trivial-devices
>>   - Fix minor formatting in dps310 document
>>
>> Changes since v2:
>>   - Fix a couple of incorrect i2c addresses
>>   - Document dps310 and max31785 properly
>>   - Drop the UCD binding documentation update, it's been fixed
>>
>> Changes since v1:
>>   - Add all the ucd9000 driver supported compatible strings
>>   - Fix node ordering in Balcones device tree
>>   - Improve commit message to explain addition of ibm-power11-dual.dtsi
>>
>> Eddie James (4):
>>    dt-bindings: arm: aspeed: add IBM Balcones board
>>    dt-bindings: iio: Add Infineon DPS310 sensor documentation
>>    dt-bindings: hwmon: Move max31785 compatibles to max31790 document
>>    ARM: dts: aspeed: Add Balcones system
>>
>>   .../bindings/arm/aspeed/aspeed.yaml           |   1 +
>>   .../devicetree/bindings/hwmon/max31785.txt    |  22 -
>>   .../bindings/hwmon/maxim,max31790.yaml        |   6 +-
>>   .../iio/pressure/infineon,dps310.yaml         |  44 +
>>   .../devicetree/bindings/trivial-devices.yaml  |   2 -
>>   MAINTAINERS                                   |   1 +
>>   arch/arm/boot/dts/aspeed/Makefile             |   1 +
>>   .../dts/aspeed/aspeed-bmc-ibm-balcones.dts    | 609 ++++++++++++++
>>   .../arm/boot/dts/aspeed/ibm-power11-dual.dtsi | 779 ++++++++++++++++++
>>   .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 769 +----------------
>>   10 files changed, 1442 insertions(+), 792 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/hwmon/max31785.txt
>>   create mode 100644 Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
>>   create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts
>>   create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi
>>
>> --
>> 2.50.1
>>
>>
>>

Andrew, are these warnings acceptable?


Thanks,

Eddie


>
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>
>    pip3 install dtschema --upgrade
>
>
> This patch series was applied (using b4) to base:
>   Base: attempting to guess base-commit...
>   Base: tags/next-20250815 (exact match)
>
> If this is not the correct base, please add 'base-commit' tag
> (or use b4 which does this automatically)
>
> New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250815194730.41695-1-eajames@linux.ibm.com:
>
> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dtb: max31785@52 (maxim,max31785a): '#address-cells', '#size-cells' do not match any of the regexes: '^fan-[0-9]+$', '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: max31785@52 (maxim,max31785a): '#address-cells', '#size-cells', 'fan@0', 'fan@1', 'fan@2', 'fan@3' do not match any of the regexes: '^fan-[0-9]+$', '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: timer (arm,armv7-timer): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /sdram@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac', 'syscon']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: bus@1e600000 (aspeed,ast2600-ahbc): compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
> 	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: syscon@1e6e2000 (aspeed,ast2600-scu): 'smp-memram@180' does not match any of the regexes: '^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^pinctrl-[0-9]+$', '^silicon-id@[0-9a-f]+$'
> 	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /ahb/apb/syscon@1e6e2000/smp-memram@180: failed to match any schema with compatible: ['aspeed,ast2600-smpmem']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /ahb/apb/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-gfx', 'syscon']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: adc@1e6e9000 (aspeed,ast2600-adc0): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: adc@1e6e9100 (aspeed,ast2600-adc1): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: crypto@1e6fa000 (aspeed,ast2600-acry): 'aspeed,ahbc' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: lpc@1e789000 (aspeed,ast2600-lpc-v2): reg-io-width: 4 is not of type 'object'
> 	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: lpc@1e789000 (aspeed,ast2600-lpc-v2): lpc-snoop@80: 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /ahb/apb/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2600-lhc']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /ahb/apb/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2600-ibt-bmc']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: sdc@1e740000 (aspeed,ast2600-sd-controller): sdhci@1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
> 	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: sdc@1e740000 (aspeed,ast2600-sd-controller): sdhci@1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
> 	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /ahb/apb/sdc@1e740000/sdhci@1e740100: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /ahb/apb/sdc@1e740000/sdhci@1e740200: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: pwm@52 (maxim,max31785a): '#address-cells', '#size-cells' do not match any of the regexes: '^fan-[0-9]+$', '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: max31785@52 (maxim,max31785a): '#address-cells', '#size-cells', 'fan@0', 'fan@1', 'fan@2', 'fan@3' do not match any of the regexes: '^fan-[0-9]+$', '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /ahb/apb/dma-controller@1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: max31785@52 (maxim,max31785a): '#address-cells', '#size-cells', 'fan@0', 'fan@1', 'fan@2', 'fan@3', 'fan@4', 'fan@5' do not match any of the regexes: '^fan-[0-9]+$', '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: /: failed to match any schema with compatible: ['ibm,bonnell-bmc', 'aspeed,ast2600']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: max31785@52 (maxim,max31785a): '#address-cells', '#size-cells', 'fan@0', 'fan@1', 'fan@2', 'fan@3', 'fan@4', 'fan@5' do not match any of the regexes: '^fan-[0-9]+$', '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: max31785@52 (maxim,max31785a): '#address-cells', '#size-cells', 'fan@0', 'fan@1', 'fan@2', 'fan@3', 'fan@4', 'fan@5' do not match any of the regexes: '^fan-[0-9]+$', '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: max31785@52 (maxim,max31785a): '#address-cells', '#size-cells', 'fan@0', 'fan@1' do not match any of the regexes: '^fan-[0-9]+$', '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
>
>
>
>
>
>

