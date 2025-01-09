Return-Path: <linux-aspeed+bounces-382-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97914E77199
	for <linux-aspeed@archiver.kernel.org>; Thu,  9 Jan 2025 14:33:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YTS1s1TMTz3bPR;
	Fri, 10 Jan 2025 01:33:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736433185;
	cv=none; b=nNk3pesNg8aKjUEg+JXv/zFklHQeFWultlt/YSmAbwIGeqz4QmVLM6ntfhY7AQOZ+LcVE/VfZetsGHPlY1D5waxfp5CGqfrDubMHOE3u79zZ0vaMpdjNg0rEZznPwX56Nm/CuWHEQLNU05mIc3yDVFNS3umcZ2Fg9y2VainU198Fo5bf3WubOXPjHxnAk+QwI/e47Z1bJw9iJKg9rkRf0E2tsAeDVAeAS1G0PRQw76nGy6P3V0O2REisrx9wADzaooJsEryAUlUhh1Rj4Z1jaj111TO9TTnAT5YUTBs4gIi2bqSmowBE6szY54+JDiNP56VnYVqcb7JuMrjEnjsxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736433185; c=relaxed/relaxed;
	bh=a4WYV/lBqDuwS3x6xguYcEfUiXeq4SXjFmogzAE4jlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oR24elExlBzlf5Ma4wBzdsE9iXTBuLNJ/leUBaKNSHnriQlNkY5YL4nL26Vwcxc+v9gIdUhy3rMSLTg21Fd90pnNQfTr1aer8kNif6BgmmSmdXn3ucDWMQKmRi8vn4FFClf10yCZsWK7RlHAtMaL3bt7CgL0kvQXRvh844B+qQrUwvkYsk+aeh0XBJJzEf7JMJzUhP15uV2tPxyx2Cy6fWSZWP+Z2ZX7c+dhwFJ4WQhlzXwaaBdgI4GDvUpGhvysFbEE/JI5XC9bynQMLwj0A5x/Jf4TJDVs5DbXWB6p2+dnaztLFs3Z7coXfIxkjwFkp02ZFPWxL2Bpo/Ud1IxvEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D35v4Vwv; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D35v4Vwv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YTS1q6mc6z30T9
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Jan 2025 01:33:03 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50985ZkV022344;
	Thu, 9 Jan 2025 14:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a4WYV/
	lBqDuwS3x6xguYcEfUiXeq4SXjFmogzAE4jlY=; b=D35v4VwvI1M8HpJsAPOasd
	eRruPQqZXqyJ3WhcCy+1kV6fZMnmxpu77zFS/dz+AJCA/cwwldDnkUESVzSkIdXa
	X3dOeIYO7HiD2dLeHTdQdSJzLcTeYLaC0e1bJs9Uh4qiMjaGOsq1SNj/qk2BC/Fe
	lPGrWYuifpNnalP+5rpCV58S5RiDHJGzj1XmozxSj01OBRSE2Q5ot+Hvl26rdr/7
	RQS94A14lVPvKTc5/imLR8zz5fBf8nLoT1EHClzJ0BCIzKYe2zje0YAV7ttYT958
	PKluzbXSlvdV82p8RlR2Q7dfJCeMPUxiGIcfTJO2fo5Vu6ZsCykGFWOPdDaLl/VQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442an2hkvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 14:32:22 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 509EOrxJ010500;
	Thu, 9 Jan 2025 14:32:21 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442an2hkvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 14:32:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 509CG5VP003593;
	Thu, 9 Jan 2025 14:32:20 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yfatdqdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 14:32:20 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 509EWKN847776206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2025 14:32:20 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 404F158056;
	Thu,  9 Jan 2025 14:32:20 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BFCA58045;
	Thu,  9 Jan 2025 14:32:16 +0000 (GMT)
Received: from [9.61.139.65] (unknown [9.61.139.65])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jan 2025 14:32:16 +0000 (GMT)
Message-ID: <6ac77e5d-e931-494a-9777-6ed0bc4aa1e9@linux.ibm.com>
Date: Thu, 9 Jan 2025 08:32:15 -0600
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
Subject: Re: [PATCH v2 05/10] ARM: dts: aspeed: system1: Add RGMII support
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
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <0c42bbd8-c09d-407b-8400-d69a82f7b248@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8L7sZPoUTETvRf7B5TvBSMQ-8W5xEmny
X-Proofpoint-ORIG-GUID: py666dZ04-ObN4IbDM5590QG7o3LXVlq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090116

Hi Andrew,

Thanks for the explanation.

On 1/8/25 11:52, Andrew Lunn wrote:
>>> Does the mac0 TX clock have an extra long clock line on the PCB?
>>>
>>> Does the mac1 TX and RX clocks have extra long clock lines on the PCB?
>>>
>>> Anything but rgmii-id is in most cases wrong, so you need a really
>>> good explanation why you need to use something else. Something that
>>> shows you understand what is going on, and why what you have is
>>> correct.
>> Here I'll add some explanation.
>>
>> In our design, we hope the TX and RX RGMII delay are configured by our MAC side.
>> We can control the TX/RX RGMII delay on MAC step by step, it is not a setting to delay to 2 ns.
>> We are not sure the all target PHYs are support for RX internal delay.
>>
>> But ast2600 MAC1/2 delay cell cannot cover range to 2 ns, MAC 3/4 can do that.
>> Therefore, when using ast2600 MAC1/2, please enable the RX internal delay on the PHY side
>> to make up for the part we cannot cover.
>>
>> Summarize our design and we recommend.
>> AST2600 MAC1/2: rgmii-rxid
>> (RGMII with internal RX delay provided by the PHY, the MAC should not add an RX delay in this
>> case)
>> AST2600 MAC3/4: rgmii
>> (RX and TX delays are added by the MAC when required)
>>
>> rgmii and rgmii-rxid are referred from ethernet-controller.yaml file.
> O.K, so you have the meaning of phy-mode wrong. phy-mode effectively
> described the PCB. Does the PCB implement the 2ns delay via extra long
> clock lines or not. If the PCB has long clock lines, phy-mode is
> 'rgmii'. If the PCB does not have long clock lines, 'rgmii-id' is
> used, meaning either the MAC or the PHY needs to add the delays.
>
> The MAC driver is the one that reads the phy-mode from the DT, and
> then it decides what to do. 95% of linux MAC drivers simply pass it
> direct to the PHY. If the phy-mode is 'rgmii', the PHY does nothing,
> because the PCB has added the delays. If it is rgmii-id, it adds
> delays in both directions. This works, because nearly very RGMII PHY
> on the market does support RGMII delays.
>
> There is however a very small number of MAC drivers which do things
> differently. Renesas produced an RDK with a PHY which could not do
> delays in the PHY, and so were forced to do the delays in the
> MAC. Please look at how the ravb driver works. If the PCB does not add
> the delays, rmgii-id, the MAC driver adds the delays. It then masks
> the phy-mode it passes to of_phy_connect() back to 'rgmii', so that
> the PHY does not add any delays. If the PCB did add the delays,
> 'rgmii', the MAC driver does not add delays, and it passed rgmii to
> the PHY driver, and it also does not add delays.

When does someone use rgmii-txid and rgmii-rxid?

Regards,

Ninad

>
> So, your MAC driver is broken. It is not correctly handling the
> phy-mode. First question is, how many boards are there in mainline
> which have broken phy-modes. If this is the first board, we can fix
> the MAC driver. If there are already boards in mainline we have to be
> much more careful when fixing this, so as not to regress boards which
> are already merged.
>
> Humm, interesting. Looking at ftgmac100.c, i don't see where you
> configure the RGMII delays in the MAC?
>
> 	  Andrew
>

