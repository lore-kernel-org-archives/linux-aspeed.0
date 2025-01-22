Return-Path: <linux-aspeed+bounces-530-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E00C02182
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jan 2025 15:10:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YdSFS1kchz2ykn;
	Thu, 23 Jan 2025 02:10:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737558652;
	cv=none; b=Lpny6UyddVk2p+vQQ9Hf2JZg5BD8ybt8/zkAzIrJJYtGckeYOhWGTrXJhRidHAKtCYrJN5mC3py+rXKEqUL+1h2wcHF+dGTDUe9agewi6JSNZGpOG4vGzVRFKSVit+F1VfK2SJSxzlZuFE35xmnkhMWsfCSgZy20vb6wvTU8pu35RzB2kppDE2z+Th63HW/IjBKuRY14b0DLrOervp6ofzbCAlBSsfjjjcQMWtmFeFysc7HgT76Q30TRpNZVEhLHdZaJyCg1bGbOUmrqzAnVcn+ukB0DDvhr35VtdrC1dZzzv5mZz0km+MtzJCDn/wpghxyPlgRE4vB4QprSLABWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737558652; c=relaxed/relaxed;
	bh=iP6JYLAn3kSqxDMH1x2eypCfziCgLVwxubhfad9Yzqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tdqp8IQb2gdib1Gz//L9i6V1gKuRNib5JvPls1IqoS6276KfyD4gTVck/7pzhWVeii7LOcjUorEJm16ui2oB6m228X3UYtc8Pwl85WM9Xf9aMhA4gJWYkpmLF9OfIHSeqLWQ4cNJUTGbz6OgCWyuDlbmEnD/mc7EIJISg6K/oMRaZqDEiOTnjEULzqFjDNgeXShYn7FFhsqprVMG0c26QqV6HO8/QumSXQeubZlXJsOiASbEqVs+iWgURLOeJ3V7iR6eewoGYM8BOZxMUWpnF30njCnr4n8UGWrmlbAqVO8kHFYdT1UY/vTvpXD6Fpm3WWyvq3P4H7zLjZq+UvEzhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oe++BO6+; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oe++BO6+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YdSFQ5yrqz2yjb
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jan 2025 02:10:50 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M7XBIe013509;
	Wed, 22 Jan 2025 15:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iP6JYL
	An3kSqxDMH1x2eypCfziCgLVwxubhfad9Yzqg=; b=oe++BO6+6YaXyzZAzm2Vfe
	asicoVzK9bzTB/35VuO19PVEov7mApKRfkrMPWfXeOYra4CfAHA1mr1lktJZf+Zv
	7Ag47fEY1i4UAi0CIPAeRwcVKNEIxnyKJu8N3fCxyPbnRLrntjgJpBs/IceK1iFY
	DJ7Fcy/106hdA/XY9MUWQ+C6qe99C20B91IyKrbYXZSwRt6YAUE85U9C+ggslZsg
	oOtEDkspkp2eVrgL7hks82sba8qZ1mgGWNzvkte47E8yHqCo3YaHrCt130KCF9n7
	nkQmY5mPCFK++maitW6BhKlvOsH9XirJYldKMx8KATkRgth6qWytCDqGgNEdpqfA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44avcp2183-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 15:10:28 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50MF5I64021452;
	Wed, 22 Jan 2025 15:10:28 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44avcp2180-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 15:10:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50MEWxV4029604;
	Wed, 22 Jan 2025 15:10:27 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448qmngxum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 15:10:27 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50MFAQnW30474798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 15:10:26 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBCE258043;
	Wed, 22 Jan 2025 15:10:26 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21C2658055;
	Wed, 22 Jan 2025 15:10:25 +0000 (GMT)
Received: from [9.67.103.45] (unknown [9.67.103.45])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jan 2025 15:10:25 +0000 (GMT)
Message-ID: <79c859c6-ff59-4641-8ae7-4136d7c3724e@linux.ibm.com>
Date: Wed, 22 Jan 2025 09:10:24 -0600
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
Subject: Re: [PATCH v6 02/10] bindings: ipmi: Add binding for IPMB device intf
To: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20250116203527.2102742-1-ninad@linux.ibm.com>
 <20250116203527.2102742-3-ninad@linux.ibm.com>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20250116203527.2102742-3-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6-n8PCpmb03FndjCSeNg3mA0W6V6JDMb
X-Proofpoint-GUID: vA3A8Mv6S_n51l7CjcDZtEnBqfbDtcHD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_06,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 mlxlogscore=838 spamscore=0 phishscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220111

Hello Corey, Rob & Krzysztof

On 1/16/25 14:35, Ninad Palsule wrote:
> Add device tree binding document for the IPMB device interface.
> This device is already in use in both driver and .dts files.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>

Do you have further comments on this? If not can you please send the ACK?

-- 
Thanks & Regards,
Ninad


