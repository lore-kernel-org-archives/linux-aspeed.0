Return-Path: <linux-aspeed+bounces-780-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB35C021B0
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Feb 2025 20:30:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yyp0q1X95z2yhD;
	Thu, 20 Feb 2025 07:30:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739997003;
	cv=none; b=A8yqBr6eaZiDl0KJrRSTU8BepDFhoDXC4i27NO8Xol+vKjpavHi5kUK5CaHVO1FCJ9V9arMJUoYMhtxC+vuteO5bVuZp1p+nmmqyOSVJ7TY7ayn4tLSvcPP2KODYiRAaD58nLGkoTJdfpE66QCpi8xhUjQyclr1C2FZ/tbXTY18V3l9fMP/Pv57b8Qn+ztudw0cv0VpksLp6m3EmiPf28TGmlWt0PJdtop9Dnd30KY3rFFMtd6YnFfVyaEhs9DV/d4hYy9K5NwORVx7/lasVMMlgWA1Km1dSJMWqBL07/5YCpv/6+2mXV82IzOByvuF0iK+aMmakQN9EqIxAuf5Dvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739997003; c=relaxed/relaxed;
	bh=CEedE7ZcaH3TCDxQ5RhUTcsx/afQlRMA76yruuPE5tI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F4tKcIlBXlaCUaYRl6cUGzcNvdWFKNgeyxzUvtyep5TB6MZTvKfKwF+aN0x8kH/sCgdkNqlda5ccyNMNz27SO1dsUjbVFcZQKvPF459aKxGNhFQWyebxIXbFh+36/Ox0kS5ZAJSc7eBggtK9DWA6NfuIvduQ9xrcgeuLZbo1f53fVxwsbI/UajdEo3A3BpDaBHqiacsjbDaqFoKoBINVaf1wwO7gRwHiSMx0e9oUGmqZV4jExhbLmMUZVp4eKOA/+WXrCfL21pW/DinMUc6YABAOMRncnAmGSk8krHY+2k6UGMtumTRTlgS5+X1nnQwNKRptb32Gel0ll567LmQ5AQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mohw0CJM; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mohw0CJM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yyp0n6YJPz2yVX
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Feb 2025 07:30:01 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JGSU0o005507
	for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Feb 2025 20:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CEedE7
	ZcaH3TCDxQ5RhUTcsx/afQlRMA76yruuPE5tI=; b=mohw0CJMuI73CeuilqfKEA
	7H+C8tCJuQQMp023PM4BIhpKN7/MSW9xv5qpH4ShQJGrvtyIfQVwqMQrwwphZtrR
	Hr7Q8E2DVBuaTcCD7AU8VnqXiaC4MFYVoX9MEn5quJaabCSHkrF6vms6y40BSi1h
	rGg4+SXkkzYRAdZVKFrxfkjKH8uItnYVdumFv+vcH6BXpJD4DZrablADw2P3KZgt
	aC3SaSquEj13RP0O3BNtjGFso+MZHPQLHvhudSvVDdjIvIaFleBKtKbamMkogrdH
	tIvCafjyj9qiHh6/JLTZtd2ZXnb+50Ptt0hyElImanKPVckZ2exmJ2SFNkjcc32g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44w650cwn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Feb 2025 20:29:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51JHMJlj027072
	for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Feb 2025 20:29:57 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w02563nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Feb 2025 20:29:57 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51JKTuae30016152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Feb 2025 20:29:56 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DD3A58056
	for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Feb 2025 20:29:56 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12C135805A
	for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Feb 2025 20:29:56 +0000 (GMT)
Received: from [9.67.5.125] (unknown [9.67.5.125])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP
	for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Feb 2025 20:29:55 +0000 (GMT)
Message-ID: <314166bf-f833-48e0-9d3f-8958534d5ca3@linux.ibm.com>
Date: Wed, 19 Feb 2025 14:29:55 -0600
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
Subject: Re: [PATCH v9 2/9] dt-bindings: gpio: ast2400-gpio: Add hogs parsing
To: linux-aspeed@lists.ozlabs.org
References: <20250204194115.3899174-1-ninad@linux.ibm.com>
 <20250204194115.3899174-3-ninad@linux.ibm.com>
 <114b92f993a1b5e2c77bbc91b42c21817af2874f.camel@codeconstruct.com.au>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <114b92f993a1b5e2c77bbc91b42c21817af2874f.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LM3pRkhuDwq6fOGfcbiS5ckN-kv5GiPy
X-Proofpoint-GUID: LM3pRkhuDwq6fOGfcbiS5ckN-kv5GiPy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_09,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=654 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190155

Hi Andrew,

On 2/4/25 18:02, Andrew Jeffery wrote:

> 
> Would you like to take this through the GPIO tree? Otherwise I'm happy
> to take it through the BMC tree with your ack.
> 
> Andrew
> 

FYI...

Linus sent a review confirmation on V7.

-- 
Thanks & Regards,
Ninad


