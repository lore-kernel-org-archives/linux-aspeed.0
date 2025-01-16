Return-Path: <linux-aspeed+bounces-505-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDA9C02183
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Jan 2025 15:10:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYmX41qS2z30Mn;
	Fri, 17 Jan 2025 02:10:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737040244;
	cv=none; b=Xj82A7x9HvvxQdu1AEGOfFdJUQIe/UIjcdjBKn8jtMMpeiZZ2gIgb7MzmnJzYg1o5tidpMnB6/QmVxiDGxi8qm2lhjTSHmBZRRM1IpvE+VcAkriQm96AiUz1iZfMwxWDAvGTcZitnZQ5bdc3TuiIJ9DsLSkFyJ8FbaQSXR5+DaB3o6CCg0O91zhRyWNtVjPOcsepadwVN7gzpws1OBxXfsUMPcXeu4HGE/a6rD60cmz9nKOborgUF8sgsqFpE3zXOmuEg6BILfknt3vV6JXYm+IPK77R8Ver4so5tlS+hUyaP/YsAf6q/QUvKqRCjzuSSm/36UTB/3yqWzUNvcu6tA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737040244; c=relaxed/relaxed;
	bh=9kMsm7jJrAx1IN2gYEC8j2oi13whyI4ysY2MoDYfRaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DCU2Ub0gXzWWmgx1NGAhtqrlMnyT3uTDvm0eRAH00t74vrVfCW3MS8wv6ZGqRx1trtpEcHH5thpTfoebnwCmDaOoKg8fudR+BUeGz7TjvRoGB9+TTqGMqn4hrDYZ6EhpSQjPziUJ4BvIpsE85jWZlBVyCuspmXiBOPBYACpRC5CQroNhYMl736VOj0BB4QEFoWLFO05qPswV94xRqVd4WEpWLPdA76VV3khPs8ESLpXEYUIJidFEErZ6fm4pKZVEs/QZeGY3uWJtrulfLnctUhcZvT0S0emnieELZ4FxQGS1Du5qDEz7th746FNVmF5yfmlnQBuUblRoK7rXoc/nRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n0efISJt; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n0efISJt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYmX33sLNz30Ff
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Jan 2025 02:10:43 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GDcZFT005641;
	Thu, 16 Jan 2025 15:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9kMsm7
	jJrAx1IN2gYEC8j2oi13whyI4ysY2MoDYfRaw=; b=n0efISJtYoPTmwZACD9/JJ
	XR81H59ZXaOeB7D2dq086jXjSvKCxh9hP/TFVOnwxlEbQsW7CHOpMvtOzcVHauv7
	jFhouCJKKMDGucfkTuOeZERwV3IKAqvdy/Rraw8JYwg02apXtvsLP655zsCxLkAX
	22ee1523s/7IDZrB7UOOsR0D8vMV0bdCd80YBqnsQIbCrbHK/4WUt8V72eLmGTya
	v05WwLOmklixfCXLaRWxPwFjR1BqvGyefx8zVF8CmPFuGLmmUXfRW0dcsrEly1hW
	j4HphjMFuzUAWs3oXxVE3rEMJH+m717ZPb1PqnBazJrZXf0gV9o1MPogpQlT89tw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkck4b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 15:10:16 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50GExBFG017832;
	Thu, 16 Jan 2025 15:10:15 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkck4av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 15:10:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GDCw1w007994;
	Thu, 16 Jan 2025 15:10:14 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443yned0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 15:10:14 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GFADIJ21299764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 15:10:14 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E665B58054;
	Thu, 16 Jan 2025 15:10:13 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1A815803F;
	Thu, 16 Jan 2025 15:10:11 +0000 (GMT)
Received: from [9.61.59.21] (unknown [9.61.59.21])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 15:10:11 +0000 (GMT)
Message-ID: <8a9724b0-440f-4647-9505-058717f7ee07@linux.ibm.com>
Date: Thu, 16 Jan 2025 09:10:10 -0600
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
Subject: Re: [PATCH v5 03/10] dt-bindings: gpio: ast2400-gpio: Add hogs
 parsing
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: minyard@acm.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20250114220147.757075-1-ninad@linux.ibm.com>
 <20250114220147.757075-4-ninad@linux.ibm.com>
 <mbtwdqpalfr2xkhnjc5c5jcjk4w5brrxmgfeydjj5j2jfze4mj@smyyogplpxss>
 <20250115142457.GA3859772-robh@kernel.org>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20250115142457.GA3859772-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TC-QwuyWLELS3rwujChq29wvqC7RmVnh
X-Proofpoint-GUID: vg3ZPGERppcMA5dqf5ZuhwOkDOxlsLVG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=717 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501160114

Hi Rob,

On 1/15/25 08:24, Rob Herring wrote:
>
> I was about to say that, but this matches what gpio-hog.yaml defines.
> Why we did both, I don't remember. We could probably eliminate
> 'hog-[0-9]+' as that doesn't appear to be used much.
>
> Long term, I want to make all gpio controllers reference a gpio
> controller schema and put the hog stuff there. Then we have the node
> names defined in 1 place.

Ok, choosing suffix.

Thanks for the review.

Regards,

Ninad



