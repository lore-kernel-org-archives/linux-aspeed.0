Return-Path: <linux-aspeed+bounces-381-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4769EE77197
	for <linux-aspeed@archiver.kernel.org>; Thu,  9 Jan 2025 14:26:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YTRsz3RTrz3bWH;
	Fri, 10 Jan 2025 01:26:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736432775;
	cv=none; b=Or6+aAPE1Qk3wMWeLpGQRZ0FkK01qF1cbt5MRmyCnoLAR+7/6feK0zIhjmLHgUm4gL8RiqIjg1Y1N8S8x0RT6hcD+OIwYUypVunOy/A/We/lbomTMt+w1FjwHERShaw4qPaNfNJ8owV+mOVZLreVOZtm2IOWWzdAGRYACcuE/7C1mPn8WAxSEXQ5V/frFK4T24/gDMW/FACMwk2antQ4nQW4cHAGJvosz2WkxVDRqxAlzEy4DLiFS3m80Kju+8kteJc1xgMQykmbgNt7drxjdreIfiuz/u5xRXoEEnXj3iX6PxMFGPxt0UhUHQyW6XlGs3t7yiTy8R+7mMffeKYcLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736432775; c=relaxed/relaxed;
	bh=YGI476X2i0MFtZ7SlukxL+5rG/T9Y7O8a6nsh6mbAB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfS8xKIHvNdCgcYJMhqKSwk41h5Z4FW6pN/mUJnSR1SBK58kgYxxhMnKtivx89ywXcAxEaTQdIkq4S07OJhXmDLAXEk/fU10p+WW55QXjW+Kuh+CmO7YO/gNoc3Gvbs2BrpeSLFBIIiRehvsyEGl5Bl2SGpMUw2Ja0eal6vJyov5ELEn4Hhy82JKa246LyrGOTDYwphgNIICj6E2Zbwg5dzQNKERsAg8yG2Qjxr5TWR6EVKu6IoV0MJ2qne3JWhNkurd22XAoaxGgrekr0SIBeH2Gb2UozS6ceFzjPGOlFoLHU1UZPEJ9UGYo8r+okPGpFVW/FwrBPk8XzcQhfxCwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qm6PuVaJ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qm6PuVaJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YTRsy0XR3z3bPR
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Jan 2025 01:26:13 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5093qwuF005687;
	Thu, 9 Jan 2025 14:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YGI476
	X2i0MFtZ7SlukxL+5rG/T9Y7O8a6nsh6mbAB0=; b=qm6PuVaJR4WO9WPmhDm0tC
	vBUUCSCbyNbnz1u0O+lidpWDmgcn020O/OhoN8RIw9HZsMsK9InAAkUf24btjcq4
	92SbmvNAcF8Aq77oStfScS+nrmu0vGyyoa3pBrPXRfnCNE7Nnh3xBm6gZnh7kd+q
	f9NSwkw/y+g+1Cvo2dBVKmHInaoYYcos7TDJXSwRDK5tZUxMuB2TPtgBafodbZvD
	ca5ihOi7zLyvRlArKSfkf3RkWmB2pXvQNYLkprCreNoNOIMfCAWppL3TSkr0bBcz
	QEF6Tc2qDhOg/CQD2cNRJsDGMWw34IMxGrUksl2GtvleUipj1uG6GC+tXP2klygA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4426xcake8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 14:25:36 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 509E6eqs029952;
	Thu, 9 Jan 2025 14:25:35 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4426xcake4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 14:25:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 509Cp7bf008861;
	Thu, 9 Jan 2025 14:25:34 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43yfq05mne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 14:25:34 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 509EPXrE33751356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2025 14:25:34 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4D3358050;
	Thu,  9 Jan 2025 14:25:33 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A78658045;
	Thu,  9 Jan 2025 14:25:29 +0000 (GMT)
Received: from [9.61.139.65] (unknown [9.61.139.65])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jan 2025 14:25:28 +0000 (GMT)
Message-ID: <c0b653ea-3fe0-4bdb-9681-bf4e3ef1364a@linux.ibm.com>
Date: Thu, 9 Jan 2025 08:25:28 -0600
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
Subject: =?UTF-8?B?UmU6IOWbnuimhjogW1BBVENIIHYyIDA1LzEwXSBBUk06IGR0czogYXNw?=
 =?UTF-8?Q?eed=3A_system1=3A_Add_RGMII_support?=
To: Andrew Lunn <andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "joel@jms.id.au"
 <joel@jms.id.au>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "minyard@acm.org" <minyard@acm.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "openipmi-developer@lists.sourceforge.net"
 <openipmi-developer@lists.sourceforge.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
        "robh@kernel.org" <robh@kernel.org>
References: <SEYPR06MB5134CC0EBA73420A4B394A009D122@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <0c42bbd8-c09d-407b-8400-d69a82f7b248@lunn.ch>
 <b2aec97b-63bc-44ed-9f6b-5052896bf350@linux.ibm.com>
 <59116067-0caa-4666-b8dc-9b3125a37e6f@lunn.ch>
 <SEYPR06MB51344BA59830265A083469489D132@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <8042c67c-04d3-41c0-9e88-8ce99839f70b@lunn.ch>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <8042c67c-04d3-41c0-9e88-8ce99839f70b@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D4QGmI7uFNHCuYmtN7glAX-odTtQtAzr
X-Proofpoint-ORIG-GUID: S-tApofsNQipGoyAdP32TWBQKlVxTdeb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501090112

Hello Andrew,

On 1/9/25 07:21, Andrew Lunn wrote:
> On Thu, Jan 09, 2025 at 10:33:20AM +0000, Jacky Chou wrote:
>> Hi Andrew,
>>
>>>> There are around 11 boards in Aspeed SOC with phy-mode set to "rgmii"
>>>> (some of them are mac0&1 and others are mac2&3). "rgmii-rxid" is only
>>> mine.
>>>> No one in aspeed SOC using "rgmii-id".
>>> O.K, so we have to be careful how we fix this. But the fact they are all equally
>>> broken might help here.
>>>
>>>>> Humm, interesting. Looking at ftgmac100.c, i don't see where you
>>>>> configure the RGMII delays in the MAC?
>>> This is going to be important. How are delays configured if they are not in the
>>> MAC driver?
>> The RGMII delay is adjusted on clk-ast2600 driver. Please refer to the following link.
>> https://github.com/AspeedTech-BMC/linux/blob/f52a0cf7c475dc576482db46759e2d854c1f36e4/drivers/clk/clk-ast2600.c#L1008
> O.K. So in your vendor tree, you have additional DT properties
> mac1-clk-delay, mac2-clk-delay, mac3-clk-delay. Which is fine, you can
> do whatever you want in your vendor tree, it is all open source.
>
> But for mainline, this will not be accepted. We have standard
> properties defined for configuring MAC delays in picoseconds:
>
>          rx-internal-delay-ps:
>            description:
>              RGMII Receive Clock Delay defined in pico seconds. This is used for
>              controllers that have configurable RX internal delays. If this
>              property is present then the MAC applies the RX delay.
>          tx-internal-delay-ps:
>            description:
>              RGMII Transmit Clock Delay defined in pico seconds. This is used for
>              controllers that have configurable TX internal delays. If this
>              property is present then the MAC applies the TX delay.
>
>
> You need to use these, and in the MAC driver, not a clock driver. That
> is also part of the issue. Your MAC driver looks correct, it just
> silently passes phy-mode to the PHY just like every other MAC
> driver. But you have some code hidden away in the clock controller
> which adds the delays. If this was in the MAC driver, where it should
> be, this broken behaviour would of been found earlier.
>
> So, looking at mainline, i see where you create a gated clock. But
> what i do not see is where you set the delays.
>
> How does this work in mainline? Is there more hidden code somewhere
> setting the ASPEED_MAC12_CLK_DLY register?

I think the code already exist in the mainline: 
https://github.com/torvalds/linux/blob/master/drivers/clk/clk-ast2600.c#L595

It is configuring SCU register in the ast2600 SOC to introduce delays. 
The mac is part of the SOC.

Regards,

Ninad

>
> 	Andrew

