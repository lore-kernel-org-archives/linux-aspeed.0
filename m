Return-Path: <linux-aspeed+bounces-369-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FBEE77188
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jan 2025 18:43:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSxdb1GVfz2xWZ;
	Thu,  9 Jan 2025 05:43:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736361827;
	cv=none; b=C4LwbH/ewWxHsQpPRNG+EmiHjsNsHnUBV92izVpT0+zHpkIde8XjXl7J+YZD7S8IsmY/tikmdZJKe7wkded6H8vraSgoEkFziSlxn8mX+Jtg8rNflz4omd6Bh+uuyIrbWiovo/RG85w9V9Xr4uPxMsYdIAqVy0eCfnUCbuZxAuouIMwr0BAqyBAC6IogvRiQzyGsjtQsuCkXCANgmD7Pdgkx8C7R6VCEDZrKVTV4N6tLMjquAFHsjk9r44FTf2vPut4rqnEOIe5K/lfxxeLpHxOKHlpmTrVTDRE3VCXKL1agXySxuuYRzS4JTiuHm1a0GXeb2HWMQLE164VrLmGQlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736361827; c=relaxed/relaxed;
	bh=mYtRemCp80tLFlE+/xAsWRxtiFamG3QA+/dcEw2lLas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxON7l3wle50oR4h0ZpMy1dN5skL3wWYlNlXc7/4C8ovU8mBl1/ABCxP/6q8JAVtg7vmqGqJqqpFl366g1mkypj0/St1jzzOzrmfbF0VKlROIGw4Y+L7sDlb+DAWaKgk7IC4bry9u++/ZexLRKjRpMJ+mkKDaK6mbnqxQCsXSqNduQS4O8zoCCpzkuDkJCgPQhtL/PiPSZy06r/jw33mv+aWKo38JGvnTikA57ERbmI4T/DF4qm8A6T5QPt7dd78ulEnjvU7AH/+9bQSqE7CbiSs6749BkFOk2F+eAAFewzDeXqJxjZ4Hj5k/X3b4EeX9TEZVxrZ/CvUvgdDe4AH+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lJGbincP; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lJGbincP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSxdY6lc7z2xLR
	for <linux-aspeed@lists.ozlabs.org>; Thu,  9 Jan 2025 05:43:45 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508DwcDD007005;
	Wed, 8 Jan 2025 18:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mYtRem
	Cp80tLFlE+/xAsWRxtiFamG3QA+/dcEw2lLas=; b=lJGbincP7UF9Damkc90vh7
	nG7kVYJV9A8x4FyuUy5lR5COyY8j+GNPMIzHMFlxqdO3R+FtAKr/xY/tsdbWWr/6
	5HXNuRjZ+C3Aup3MOyf+3yzaCKXyxd/Zp6G3kRNCcaNG34wmIfM18nvhhcCQnRHK
	KiZtvxuMtvYQxHBfBal4rwSsV9u4DUcKLCREtroAVKSHt0PCQcPv+NYjGXZkzu+V
	CtHSo+G0Ec9zn/jzC95lizV67beMMqx+/+hJebp4YIb0i4Z140vBGngJa8gb5a+c
	TANLK5MJKnsqTmJklJj53dC/qzxxAv/RxiW5T3XzoMIr/f4XptbFbGh6OujRSf6g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441hupuxv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 18:43:12 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 508IhBCm023005;
	Wed, 8 Jan 2025 18:43:11 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441hupuxv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 18:43:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508H6MkV013698;
	Wed, 8 Jan 2025 18:43:10 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygap1667-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 18:43:10 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 508Ih9mx5374478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2025 18:43:09 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBB5A58055;
	Wed,  8 Jan 2025 18:43:09 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2B175805E;
	Wed,  8 Jan 2025 18:43:07 +0000 (GMT)
Received: from [9.61.139.65] (unknown [9.61.139.65])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jan 2025 18:43:07 +0000 (GMT)
Message-ID: <0aaa13de-2282-4ea3-a11b-4edefb7d6dd3@linux.ibm.com>
Date: Wed, 8 Jan 2025 12:43:07 -0600
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
Subject: Re: [PATCH v3 05/10] ARM: dts: aspeed: system1: Add RGMII support
To: Andrew Lunn <andrew@lunn.ch>
Cc: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, ratbert@faraday-tech.com,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20250108163640.1374680-1-ninad@linux.ibm.com>
 <20250108163640.1374680-6-ninad@linux.ibm.com>
 <1dd0165b-22ff-4354-bfcb-85027e787830@lunn.ch>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <1dd0165b-22ff-4354-bfcb-85027e787830@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jSCdY-RcrAV3Tg1-H2uMXbGEzQHXqos9
X-Proofpoint-GUID: 3HvDLVy_vybxQ6gOrGDeaIu4ilBJS-Hv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1011 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 mlxlogscore=899
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080152

Hello Andrew,


On 1/8/25 11:03, Andrew Lunn wrote:
> On Wed, Jan 08, 2025 at 10:36:33AM -0600, Ninad Palsule wrote:
>> system1 has 2 transceiver connected through the RGMII interfaces. Added
>> device tree entry to enable RGMII support.
>>
>> ASPEED AST2600 documentation recommends using 'rgmii-rxid' as a
>> 'phy-mode' for mac0 and mac1 to enable the RX interface delay from the
>> PHY chip.
> You appear to if ignored my comment. Please don't do that. If you have
> no idea about RGMII delays, please say so, so i can help you debug
> what is wrong.
>
> NACK

I think there is a misunderstanding. I did not ignore your comment. I 
have contacted ASPEED and asked them to respond. I think Jacky from 
Aspeed replied to your mail.


Regards,

Ninad

>
> 	Andrew
>

