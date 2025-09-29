Return-Path: <linux-aspeed+bounces-2355-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18764CAC5B5
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Sep 2025 14:52:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cb41P5gQKz30MY;
	Tue, 30 Sep 2025 00:52:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759157577;
	cv=none; b=XgnZ21vcPosngTnWRnDultG5irh4nfrbx+Izlixu6uKeRz2dU7omeghcqM3pfOUzrOEt6H+LVs3z6v0QY/Nj8+o/AiBlqfMe2ymiRU5cEXJeV5VlfvFdfJVhFGtdZTySxNTQUueXVzu695whqVym8qH4TYaVbQs4Zm1JeuPg6LJnIofgnIG28GbsGBKi6o9mgLDxt0BPNkUXdlbYZ/jpUzY1JHCUMIi1QLvuX2W+JfUJ2SSR2uGrLDevsdy5szWGJ7yN9bR2ng2aBnBPlH+9MoBuz+mJkPxJVEJC88JJWPt9++ANkYvOMx2gsXj/+Vd6vU5nTGmW/ZrBQ+XxRhjf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759157577; c=relaxed/relaxed;
	bh=O3X5SUPwlwylRDopseRYu3eFe8osZTObK90pXgudQ0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nShBS/wqstDCJDEmBZLCBzCPiWo5kEnnYELCrIQymTf0r9hHDUXZFDpYSR6iAWFhZZuImHisTutRgBluveXXna/Iayk688R8w6oRP9ruFrzxMmDd7C9ipAquhpa9VX6jEjfHzAFCTWUpXAb3NoR0UeCvni5IBQByt4QJrKbrFG/7uKBZfxvOVfgAs+vUOH0acxYBz9FBOnNNnn7RutjxJyeKv8wCV2uIKvoUIhARDOLfLHIkvbmwRXKSVjSosixNu/6YQw4nQTBtW9pjeGCNz4l2xzRr5n++YW4NzEM6yGHInoN2TJUMmse95+T0NXkmAvYwuHlakJNVvtJwqL8/0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TR3Pxx1J; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TR3Pxx1J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cb41N5h3Zz2xQ5
	for <linux-aspeed@lists.ozlabs.org>; Tue, 30 Sep 2025 00:52:56 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TChMom021005;
	Mon, 29 Sep 2025 14:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=O3X5SU
	PwlwylRDopseRYu3eFe8osZTObK90pXgudQ0c=; b=TR3Pxx1Jz4sBBekoMk4JXJ
	Gc1+ekVim+ISmOZyS+nCXJ9PJqcT/rOrZfBQ5zff4HB0dHE+fBhz4ega7hRgFAWX
	F3xe0Zg9b13CiBlGtlLVCNDCDtD9RJ2bMFiv5nKFVVAjRlHbtCc9gWMqaPYCKmk9
	NJ1wRTd3F/qvmHXvhgiEbGbd6vqCWK9XW5Vv6PIqjZHDsi31xkFwYzBKsr4OtgNl
	ubM0TJ0X0e2LqQMjugWjPL1pZKNQ1K8Veb+T3exOf6QyyxTK3EAL+b+77dSl4k6M
	yKaJVU54y9y4iF+UnoT5iQbYAfZUddug2yO1NDDO4VjlThHmTidbnLWAOA4t4cJg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jwankk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 14:52:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58TCRVX7020074;
	Mon, 29 Sep 2025 14:52:46 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49et8rxrcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 14:52:46 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58TEqkHc32113338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 14:52:46 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 126C558061;
	Mon, 29 Sep 2025 14:52:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBF205803F;
	Mon, 29 Sep 2025 14:52:45 +0000 (GMT)
Received: from [9.61.71.223] (unknown [9.61.71.223])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Sep 2025 14:52:45 +0000 (GMT)
Message-ID: <4632dab2-d6c7-4abf-8449-bd61d5ad94ad@linux.ibm.com>
Date: Mon, 29 Sep 2025 09:52:45 -0500
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
Subject: Re: [PATCH v7 6/7] ARM: dts: aspeed: Add Balcones system
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
        robh@kernel.org
References: <20250922175804.31679-1-eajames@linux.ibm.com>
 <20250922175804.31679-7-eajames@linux.ibm.com>
 <6d117ac3297628ee6e315894460d348647b68c7f.camel@codeconstruct.com.au>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <6d117ac3297628ee6e315894460d348647b68c7f.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX6KJpFwUYzZtT
 bJIwsd69uh7pRz05OJkxP/0HFnYX9K1JZDa76A0FWQDeq/948kqMkAvqjlEAOXYudttVOVxNYof
 VsIWeQ0zSOfkOEjoxFG6EMHwX8XkX3Pe9mVuer0PllWxw0+QVVDrk1kaDF/okqrwi2Fy47BvdjY
 cwIZKXwngRbSH5SbYcxfD07KWFEZUWuId0yJNruZ2nj441gFtkNWUAITugHxr/7CpEpfMSk54p3
 HT3VfyYhacatq1EE/OOPVaQpncFEXtT1UngtDdrMHFoDib31Usrsmrxyc32Z3Rs/fxaQzm88Rug
 0rtnbJDy9Ng04CeifrfArNRXmZx/2/KRudbz8twlqD3LPvUTQjNUiO3Q0Tt6W/ZXnjDGRk908S2
 +/ucwluSrQkpYmLoGo6lVUint9bGnw==
X-Proofpoint-ORIG-GUID: arEhpDA21VYEfHWZizOxrJWmHhJLIZka
X-Proofpoint-GUID: arEhpDA21VYEfHWZizOxrJWmHhJLIZka
X-Authority-Analysis: v=2.4 cv=GdUaXAXL c=1 sm=1 tr=0 ts=68da9d3f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=gEfo2CItAAAA:8 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=w5x8F5CJSgKQt7ywA40A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_05,2025-09-29_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025


On 9/25/25 7:03 PM, Andrew Jeffery wrote:
> On Mon, 2025-09-22 at 12:58 -0500, Eddie James wrote:
>> The Balcones system is similar to Bonnell but with a POWER11 processor.
>> Like POWER10, the POWER11 is a dual-chip module, so a dual chip FSI
>> tree is needed. Therefore, split up the quad chip FSI tree.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   arch/arm/boot/dts/aspeed/Makefile             |   1 +
>>   .../dts/aspeed/aspeed-bmc-ibm-balcones.dts    | 609 ++++++++++++++
> Looking at Balcones specifically, there's still an immediate concern:
>
>     /home/andrew/src/kernel.org/linux/origin/build.arm.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: pressure-sensor@76 (infineon,dps310): '#io-channel-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
>             from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#


Hmm, patch 3 in the series fixes this. Did you apply that one? Here is 
my output from CHECK_DTBS for balcones:


$ make CHECK_DTBS=y dtbs
   DTC [C] arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb
/home/eajames/development/linux/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: 
timer (arm,armv7-timer): 'clocks' does not match any of the regexes: 
'^pinctrl-[0-9]+$'
         from schema $id: 
http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
/home/eajames/development/linux/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: 
sdram@1e6e0000 (aspeed,ast2600-sdram-edac): compatible: 
['aspeed,ast2600-sdram-edac', 'syscon'] is too long
         from schema $id: 
http://devicetree.org/schemas/edac/aspeed,ast2400-sdram-edac.yaml#
/home/eajames/development/linux/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: 
bus@1e600000 (aspeed,ast2600-ahbc): compatible: ['aspeed,ast2600-ahbc', 
'syscon'] is too long
         from schema $id: 
http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
/home/eajames/development/linux/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: 
syscon@1e6e2000 (aspeed,ast2600-scu): 'smp-memram@180' does not match 
any of the regexes: '^interrupt-controller@[0-9a-f]+$', 
'^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^pinctrl-[0-9]+$', 
'^silicon-id@[0-9a-f]+$'
         from schema $id: 
http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: 
/ahb/apb/syscon@1e6e2000/smp-memram@180: failed to match any schema with 
compatible: ['aspeed,ast2600-smpmem']
/home/eajames/development/linux/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: 
adc@1e6e9000 (aspeed,ast2600-adc0): 'interrupts' does not match any of 
the regexes: '^pinctrl-[0-9]+$'
         from schema $id: 
http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
/home/eajames/development/linux/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: 
adc@1e6e9100 (aspeed,ast2600-adc1): 'interrupts' does not match any of 
the regexes: '^pinctrl-[0-9]+$'
         from schema $id: 
http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
/home/eajames/development/linux/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: 
crypto@1e6fa000 (aspeed,ast2600-acry): 'aspeed,ahbc' does not match any 
of the regexes: '^pinctrl-[0-9]+$'
         from schema $id: 
http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: 
/ahb/apb/lpc@1e789000/lhc@a0: failed to match any schema with 
compatible: ['aspeed,ast2600-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: 
/ahb/apb/lpc@1e789000/ibt@140: failed to match any schema with 
compatible: ['aspeed,ast2600-ibt-bmc']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: 
/ahb/apb/dma-controller@1e79e000: failed to match any schema with 
compatible: ['aspeed,ast2600-udma']



>
> On the whole though it's much cleaner than other IBM devicetrees, just
> the DTSI warnings remain. I'd appreciate it if you have some time for
> cleanups to Rainier, Everest and Bonnell, the number of warnings is
> really quite large :(


Yea, I can try and get to it eventually :)


Thanks!

Eddie


>
> Andrew
>

