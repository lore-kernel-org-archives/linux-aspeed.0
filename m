Return-Path: <linux-aspeed+bounces-326-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68763E77197
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Jan 2025 14:46:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSDQc73kvz3041;
	Wed,  8 Jan 2025 01:46:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736261208;
	cv=none; b=CSMfb9Fw29UwoqbLQgngZJCaJ50bUysSwLP4Uyio1YSxf47GvpGyXsqLlxB9dnkQKLMIdENlnRjx32st7AaaUyOcRb3yRbVZeZrsOKoplTNf1Akr1276bFv4ZHd09HvnkyBiE+akMSf068bRkGcp+63odPBVBe6H9EubzbJjpSGHPAcDvxyaNvLbiVR0csHUDbRVE8o3y0hWyhJs2Zrht4zKQwE+m72OoXR0bE3oyjVLQ9fgBPVaRv+zqOhd/uZPlOVGdq+yp3NM/tTLGdAtcFoC0yYtXGdwdwcq+CxaB/3Lbkufnx4weLbWYi9eW4vW/PZA73JS5sGrY+5c3qagiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736261208; c=relaxed/relaxed;
	bh=cxPAWL+xin5vhaohLcuT2Ap42giFDWZcynaNDWdW+q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZyWoS5Oq8kVNkojYwaG3YUItD0mZRWzb7nlknAcHLuEZOfeuAxPbOiQT9IYLRZoLuuhNJTg6+hJC1mJh1MSAPFse4Iw+Nao9HxTXxsOKhpBv5PfAGH+56wPTJbapk1gdYWJgA6udC237C3G0B8vdzGeRPee6a6s9fmfNkS7pyfo487IDaIAMU7ENy8eF9fodrW8mrxuYfHdaulwLfdcCkEtpLfmvAmF22bKGMiPtO75uPE9H9u6xtLJd8/KyqTcTOddVCkvPTfXgTI98QmWy8uRDTu+9g9lqd9hfnTTRSRANToMcokKi7GTrCSqz5beUHyiNDDdRXIIxwsI2GVe2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e+K3y++t; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e+K3y++t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSDQX6JDXz300V
	for <linux-aspeed@lists.ozlabs.org>; Wed,  8 Jan 2025 01:46:44 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507CSl8Y022183;
	Tue, 7 Jan 2025 14:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cxPAWL
	+xin5vhaohLcuT2Ap42giFDWZcynaNDWdW+q8=; b=e+K3y++tUnqNiNA9nBLNVW
	gx6CXe7emtQEL0KdWn8Iwyyk0FFaBKLpgeNkcq+pKe5scB5C2RKeH6yMgKa4DWot
	kx7e9aoutEAYKzwZLajtW/8QSmH4sY/dOwiYSo6Tx8otiGxLW70dhBRW69cT113F
	9w16nnuYWCAPMLZZ42NuMgz9hKHmKbVB3L9CeVhTBtAjJbp7QuBX1r/amhy7hQrd
	aoGEAFpKoEr8oh1LPyygeb3fpybsUxbaJIy4TEkMr+4B4cPVN9clOh+KOOYoEjT4
	bZ+U0Wsx4Pe9DLNVP5bDDtUH+aQ+NgGBcMQLwRKVvRsA01X5M1b3ufYso0RNpjjw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 440sahkg16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 14:46:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 507CmmI5008866;
	Tue, 7 Jan 2025 14:46:15 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43yfpyu1yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 14:46:15 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 507EkF8M24052330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jan 2025 14:46:15 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC95858062;
	Tue,  7 Jan 2025 14:46:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66C755805E;
	Tue,  7 Jan 2025 14:46:14 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jan 2025 14:46:14 +0000 (GMT)
Message-ID: <3ffe898a-6146-4001-9d7a-53b45fbc8945@linux.ibm.com>
Date: Tue, 7 Jan 2025 08:46:14 -0600
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
Subject: Re: [PATCH v1 0/8] DTS updates for system1 BMC
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: andrew@codeconstruct.com.au, linux-arm-kernel@lists.infradead.org,
        krzk+dt@kernel.org, eajames@linux.ibm.com, joel@jms.id.au,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org
References: <20241213145037.3784931-1-ninad@linux.ibm.com>
 <173436597537.264948.12611164276777551472.robh@kernel.org>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <173436597537.264948.12611164276777551472.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OWui3oiuVa11k1Zs0pdqjBoTK3NqWjdc
X-Proofpoint-ORIG-GUID: OWui3oiuVa11k1Zs0pdqjBoTK3NqWjdc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=948 impostorscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070122

Hello Rob,

Thanks for the review. Sorry for the late reply due to vacation.

On 12/16/24 10:29, Rob Herring (Arm) wrote:
> On Fri, 13 Dec 2024 08:50:26 -0600, Ninad Palsule wrote:
>> Hello
>>
>> Please review the patch set. It has various device tree changes for
>> system1 BMC after hardware testing.
>>
>> NINAD PALSULE (7):
>>    ARM: dts: aspeed: system1: Add IPMB device
>>    ARM: dts: aspeed: system1: Add GPIO line name
>>    ARM: dts: aspeed: system1: Add RGMII support
>>    ARM: dts: aspeed: system1: Reduce sgpio speed
>>    ARM: dts: aspeed: system1: Update LED gpio name
>>    ARM: dts: aspeed: system1: Remove VRs max8952
>>    ARM: dts: aspeed: system1: Mark GPIO line high/low
>>
>> Ninad Palsule (1):
>>    ARM: dts: aspeed: system1: Disable gpio pull down
>>
>>   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 178 ++++++++++++------
>>   1 file changed, 119 insertions(+), 59 deletions(-)
>>
>> --
>> 2.43.0
>>
>>
>>
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
> New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ibm-system1.dtb' for 20241213145037.3784931-1-ninad@linux.ibm.com:
>
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: ethernet@1e660000: phy-mode:0: 'rgmii-rxid' is not one of ['rgmii', 'rmii']
> 	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
Added rgmii-rxid mode in the yaml file.
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: gpio@1e780000: 'fan_controller_reset', 'isolate_errs_cpu1', 'rtc_reset', 'srtc_reset' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#

I am still not sure about this error.

/home/ninad/dev/sbp1/linux/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: 
gpio@1e780000: 'hog-0', 'hog-1', 'hog-2', 'hog-3' do not match any of 
the regexes: 'pinctrl-[0-9]+'
     from schema $id: 
http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#

> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: rtc_reset: $nodename:0: 'rtc_reset' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$'
> 	from schema $id: http://devicetree.org/schemas/gpio/gpio-hog.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: srtc_reset: $nodename:0: 'srtc_reset' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$'
> 	from schema $id: http://devicetree.org/schemas/gpio/gpio-hog.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: fan_controller_reset: $nodename:0: 'fan_controller_reset' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$'
> 	from schema $id: http://devicetree.org/schemas/gpio/gpio-hog.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: isolate_errs_cpu1: $nodename:0: 'isolate_errs_cpu1' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$'
> 	from schema $id: http://devicetree.org/schemas/gpio/gpio-hog.yaml#
Changed to generic name hog-0...3
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/apb@1e780000/bus@1e78a000/i2c@280/bmc_slave@10: failed to match any schema with compatible: ['ipmb-dev']

Documented IPMB device interface.

Regards,

Ninad

>
>
>
>
>
>

