Return-Path: <linux-aspeed+bounces-788-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6097BC021B2
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Feb 2025 14:36:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YzG6r38wqz30TH;
	Fri, 21 Feb 2025 01:36:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740062212;
	cv=none; b=TUDg23NEmJM5SdUN0xHD7gIbd64zmAaYI+jZK6n6gVJuqedjqdxmJXotAf4xl8c69xyClnn8WGkVbvZICBgFye2sK0f0MraXMF7yjuzA5Ut046Nwo0PQM/2NfvDfgPQAVfEtHGm+/AqFUn2BIJMTE6j5nWo+nwiYevBmlusCMed1XD9CDGFJNOEnMBplX9X8CLz9FuGPkzJpCirhB5cs8i4OwezvOaMBl2H9A7+VS7EifKma5J8lZ193jF6NughSoO7UvR1zSna9g1W60py45+OIW95hBpi+1/jYVEeZDqhZvjQb5mGfyjtwWluB/Ny7PYIqtGlNbf/VMdYHlPJqQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740062212; c=relaxed/relaxed;
	bh=LvAve/4dkDe4Xg3pY33uohABuN5Ael5Y3OV6lbiTz/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oaZ+xCist0lumwOHRSRCcP52XS3B4HAH3IuVk1uOTI2YrA/TwGbGAYuS4RHc6pW9lkQwquWBNr9AU9CD6mFVZThLQBbgLHMcrr3yfsBSBpNBkh+Y+cg0XaLcUZBElK1+XwIKGZzx1FAI0vIRjwA0hN/HWOVONDsZLapWv9TtUSNTYCWr/t5uzL0lyyeXwg5YOtPOkwQ0YcWMtOmQ1sv58uQRnp0weg3u4iPSVLb3DOpIUcosMP+Dwr7xtfZDyDM8hsI5nggsWkyq3/He8fAej4+tiHBkkLDX4iyMhNsxXXqtB6QsRPVkU7CI05jEEHCc/iEOqezte5EuNDamnziJ9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JJvQBzuL; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JJvQBzuL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YzG6q2PZYz2yRF
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Feb 2025 01:36:50 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KBGPnT012316;
	Thu, 20 Feb 2025 14:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LvAve/
	4dkDe4Xg3pY33uohABuN5Ael5Y3OV6lbiTz/8=; b=JJvQBzuLGxq64136OfYCzU
	yvUE6dBAUN8BnQVzbCRrJQ4mN8xVHaEQC+ou770SGNls3AaJ9BuMrZXmt0kqfHYO
	A2DGViQvkEVQZkOxhsStz4GCBRRP4A3ZaEHPDmYp203rjjroOCw7fgxdeNnEoqCx
	stU/2BfFlIngjidKrTg/qmPq1n5c2LaRJYRF5qiKuEfMGCZV/CzwtwVHyqYhsNg2
	1hc064XMUj7Wr/DvOOZU3J8TW2FF6dnKAJ8qkTPOUj74m2B0GFFSepo7x0aDt5iC
	sUlKjfqwMdygHEA6pfbLzxUohL09GWC6U/YEQsGcoFiLxA800yXuwNS/d3Qug1gA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wreabxt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 14:36:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KBbF4l002336;
	Thu, 20 Feb 2025 14:36:41 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03xaejt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 14:36:40 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KEaekW29164202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 14:36:40 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28C9E58054;
	Thu, 20 Feb 2025 14:36:40 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA5B558055;
	Thu, 20 Feb 2025 14:36:39 +0000 (GMT)
Received: from [9.61.48.195] (unknown [9.61.48.195])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 14:36:39 +0000 (GMT)
Message-ID: <97e9990b-7c08-41c7-aa8d-b6d13be2a2a7@linux.ibm.com>
Date: Thu, 20 Feb 2025 08:36:37 -0600
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: dts: aspeed: Add Balcones system
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-aspeed@lists.ozlabs.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
References: <20250219212735.1365050-1-eajames@linux.ibm.com>
 <20250219212735.1365050-4-eajames@linux.ibm.com>
 <379b87b84ae79ce6cb49ee27410e628518e0e269.camel@codeconstruct.com.au>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <379b87b84ae79ce6cb49ee27410e628518e0e269.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: teamT-6vmMHbdymMoxeWy7jWGTWxFoNu
X-Proofpoint-GUID: teamT-6vmMHbdymMoxeWy7jWGTWxFoNu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200104


On 2/19/25 18:41, Andrew Jeffery wrote:
> Hi Eddie,
>
> I have some minor comments inline:
>
> On Wed, 2025-02-19 at 15:27 -0600, Eddie James wrote:
>> The Balcones system is similar to Bonnell but with a POWER11 processor.
> Can you add some commentary about the P11 dual vs quad changes here?


Yes I will.


>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   arch/arm/boot/dts/aspeed/Makefile             |   1 +
>>   .../dts/aspeed/aspeed-bmc-ibm-balcones.dts    | 594 +++++++++++++
>>   .../arm/boot/dts/aspeed/ibm-power11-dual.dtsi | 779 ++++++++++++++++++
>>   .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 769 +----------------
>>   4 files changed, 1376 insertions(+), 767 deletions(-)
>>   create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts
>>   create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi
>>
>> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
>> index 2e5f4833a073b..71b2d67fdbac8 100644
>> --- a/arch/arm/boot/dts/aspeed/Makefile
>> +++ b/arch/arm/boot/dts/aspeed/Makefile
>> @@ -34,6 +34,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>>          aspeed-bmc-facebook-yamp.dtb \
>>          aspeed-bmc-facebook-yosemitev2.dtb \
>>          aspeed-bmc-facebook-yosemite4.dtb \
>> +       aspeed-bmc-ibm-balcones.dtb \
>>          aspeed-bmc-ibm-blueridge.dtb \
>>          aspeed-bmc-ibm-bonnell.dtb \
>>          aspeed-bmc-ibm-everest.dtb \
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts
>> new file mode 100644
>> index 0000000000000..0fe99a748b63b
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts
>> @@ -0,0 +1,594 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +// Copyright 2025 IBM Corp.
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/gpio/aspeed-gpio.h>
>> +#include <dt-bindings/i2c/i2c.h>
>> +#include <dt-bindings/leds/leds-pca955x.h>
>> +#include "aspeed-g6.dtsi"
>> +#include "ibm-power11-dual.dtsi"
>> +
>> +/ {
>> +       model = "Balcones";
>> +       compatible = "ibm,balcones-bmc", "aspeed,ast2600";
>> +
>>
> ...
>
>> +};
>> +
>> +&i2c0 {
>> +       status = "okay";
>> +
>> +       eeprom@51 {
>> +               compatible = "atmel,24c64";
>> +               reg = <0x51>;
>> +       };
>> +
>> +       gpio@20 {
> Can you please follow the DTS coding style and order the nodes by unit
> address?
>
> https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-nodes
>
> Ordering the top-level label references alphabetically would be
> appreciated too. It doesn't seem like they're in an order reflecting
> e.g. the unit address, it feels kind of arbitrary.


Oops yep, I'll fix all these.


>
>> +               compatible = "ti,tca9554";
>> +               reg = <0x20>;
>> +               gpio-controller;
>> +               #gpio-cells = <2>;
>> +
>> +               gpio-line-names =
>> +                       "",
>> +                       "RUSSEL_FW_I2C_ENABLE_N",
>> +                       "RUSSEL_OPPANEL_PRESENCE_N",
>> +                       "BLYTH_OPPANEL_PRESENCE_N",
>> +                       "CPU_TPM_CARD_PRESENT_N",
>> +                       "",
>> +                       "",
>> +                       "DASD_BP_PRESENT_N";
>> +       };
>> +};
>> +
> ...
>
>> +
>> +&i2c5 {
>> +       status = "okay";
>> +
>> +       eeprom@52 {
>> +               compatible = "atmel,24c64";
>> +               reg = <0x52>;
>> +       };
>> +
>> +       temperature-sensor@4e {
> Ordering again here.
>
>> +               compatible = "ti,tmp435";
>> +               reg = <0x4e>;
>> +       };
>> +};
>>
> ...
>
>> +
>> +&kcs3 {
>> +       status = "okay";
>> +       aspeed,lpc-io-reg = <0xca2>;
>> +       aspeed,lpc-interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
>> +};
>> diff --git a/arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi b/arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi
>> new file mode 100644
>> index 0000000000000..e5f65258e082f
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi
>> @@ -0,0 +1,779 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +// Copyright 2025 IBM Corp.
>> +
>> +/ {
>>
> ...
>
>> +
>> +&fsim0 {
>> +       #address-cells = <2>;
>> +       #size-cells = <0>;
>> +       status = "okay";
>> +       bus-frequency = <100000000>;
>> +       cfam-reset-gpios = <&gpio0 ASPEED_GPIO(Q, 0) GPIO_ACTIVE_HIGH>;
>> +
>> +       cfam@0,0 {
>> +               reg = <0 0>;
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               chip-id = <0>;
>> +
>> +
> ...
>
>> +
>> +               sbefifo@2400 {
>> +                       compatible = "ibm,p9-sbefifo";
>> +                       reg = <0x2400 0x400>;
>> +
>> +                       occ {
>> +                               compatible = "ibm,p10-occ";
> I assume this doesn't need a new compatible for P11 (given you're
> moving it out of the quad DTSI).


That is correct. FSI all remains the same for P11.


Thanks for the review!

Eddie


>
> Andrew

