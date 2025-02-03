Return-Path: <linux-aspeed+bounces-620-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE407C02192
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Feb 2025 15:18:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YmqrF2vJxz2xsW;
	Tue,  4 Feb 2025 02:18:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738595885;
	cv=none; b=cXupGQNJ7JoiIRkOE4eWv8rVN/bcJXu99VdqoNCK4pygYyHCOwUvqKznTNLvQZ766TYEiIbrNSbtAznAlBTm9vTC9nbs9FqGo3jJVP4Bgcb0gz+FyIaMtsOe+lIDNHlZDpCXnC7IidVSgNFTLNPcNmN3uFZT0xQcZ8t/4FQoHjDix6xYehMlSmfjIRvMq9ZX0YIqwHZzFY31VmS45I3BamLXnng2FTPyW+WuC7YUIOp7OQO2C31s7WYckMD9YQIZmIllZNGE9orXcTWZcMDk9IoN6Pid4tQwic7V5oXRvcZ68/b06V5LO/rh+ePTnwFWloO7qj9EKDxBoIH+Djs5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738595885; c=relaxed/relaxed;
	bh=VQ4RqG5wX63XHkwCiEdYMzRbUoNudhkrKOhuQwdpm0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZucE0STdL23qxuyB52r2uTSSiO6AJ+WUfmSxoZO0w8rVuklRvF4cEow9pI27Ty8+J433LfgqGvIgYyQ8LXNuGrqxoDAhW6wn6Yqm4+42M3p8GaweTAzqwBW/3mkFGN/T+kjlhKukaUaiEac77tDz0Vr3mW67egq4TKBlqMpyTyXxvgGuZdHshN0W+GF4/XxoYU/pO4SSMzPy0FAlGz1Dihcsz1Dqy71l64cmQQIEcNH+ZpeW9NFJzIHmukvNPdIAvMRds0AJpiEKeS67TSvZefXXvs1L9ynWxQL8T4TUEU0UDJN8FLv8Gd0MyTGecFydsVMViYBJTaLrAo8mKhzbWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Nlc1VyEi; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Nlc1VyEi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YmqrD0n2pz2xk7
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Feb 2025 02:18:03 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5137X6YA014781;
	Mon, 3 Feb 2025 15:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VQ4RqG
	5wX63XHkwCiEdYMzRbUoNudhkrKOhuQwdpm0I=; b=Nlc1VyEiuQjiYLbh9pocM7
	CLzpw0KGTWnPjmqHhoJdctttDND+tQK9HnMGI7+5OzI4UOPiC2g1jfxT+E/4BtIV
	sRXuqVCYEY+QMYpq+kzCJlXYPJJKcC/jr+wBiAnRpFY1GMFrD3kBYJg2cRwGp8VN
	3vDv5GV8RucvxRppCS/1GVFpv1u6Bscij0K+xur3Wb5seNOMbt1BYWKIU0Ts97yT
	yV9Ttyl3qwNR7zYjITItgwJC86BAgbspV7aWTEhxK+vwY8P2JFALSNld4SwgDHCL
	AU/IXMdkZIM/eZ4ifT84xINshzb+HcutkwCXvamEvqn+VMPoIEEZ7wRGln1XR9ow
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jsgnj3w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 15:17:40 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 513FGR11024317;
	Mon, 3 Feb 2025 15:17:40 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jsgnj3w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 15:17:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 513C7pcF024493;
	Mon, 3 Feb 2025 15:17:39 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxxmxxnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 15:17:39 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 513FHcae18088686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2025 15:17:38 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F3EC58059;
	Mon,  3 Feb 2025 15:17:38 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 301B95804B;
	Mon,  3 Feb 2025 15:17:37 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Feb 2025 15:17:37 +0000 (GMT)
Message-ID: <c06056b4-db8a-4c0b-b061-aa596d3519f8@linux.ibm.com>
Date: Mon, 3 Feb 2025 09:17:36 -0600
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
Subject: Re: [PATCH v7 1/9] bindings: ipmi: Add binding for IPMB device intf
To: Krzysztof Kozlowski <krzk@kernel.org>, brgl@bgdev.pl,
        linus.walleij@linaro.org, minyard@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, openipmi-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20250203144422.269948-1-ninad@linux.ibm.com>
 <20250203144422.269948-2-ninad@linux.ibm.com>
 <6def1c5d-d1a0-4a6f-9db2-453692d5423d@kernel.org>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <6def1c5d-d1a0-4a6f-9db2-453692d5423d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bmeP0_XdLDJr4zTpejIH4blsVibc7Jc7
X-Proofpoint-ORIG-GUID: LEkVc5s_HyeQNjFOjksxZRwmsKHp-Du9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=994 phishscore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030110

Hi Krzysztof,

Thanks for the review.


>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> You still need to fix the subject. Why patch #1 has bindings but patch
> #2 dt-bindings? Why can't this be consistent?

What is preferred now a days? bindings or dt-bindings?

-- 
Thanks & Regards,
Ninad


