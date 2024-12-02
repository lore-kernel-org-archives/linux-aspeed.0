Return-Path: <linux-aspeed+bounces-178-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72EEE69E86
	for <linux-aspeed@archiver.kernel.org>; Mon,  2 Dec 2024 19:43:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y2Djz1y2Gz2yVd;
	Tue,  3 Dec 2024 06:43:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733168631;
	cv=none; b=P4kM1v8Me01452p9yCvKTo13E8T6JhXlwfx1G+JgV9Xx9tHqNY7bYdJfcZXszd9g9JkVGdMrZ1dxd08KX7vayklLbhf4HwgFURlAipTbwce8ieYosUK5F+jGlIooF3gl47q/tX2djaInHsADuJxqMVnmAHB2YSVRmShnyYaqNzu2TltyIg91xvh3EyWK7fIzDMP0T90S3HiXDrpvr+N17ZeS4Qx/vNYIyPbZQYXCFb0/P+F18yNyr1HBdjB3CxPTEK+my/t/W3xSkIOvMGildMwxxX/1LWVxRVgmCqDzCY0fwlVojVs60ukHNltfbZDp/RIWJ3TQBZoiDGorGFNdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733168631; c=relaxed/relaxed;
	bh=PtthdvLNczidenLf1mjfjYZczot34nYiKDi3OMmwcXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVCnYVm8Q7LBy0hrYCAXBBqNUnYyXrUTsvVRBy535og7xnO6HAGc5aruqG6X4PhNsvlaLc2xPqkmcd6nfMjPGmko5xDVNjD7Ue+AOubYiAlziEmeQ8O8a1s7sndV/WPfJsMKQPS6YrbG0CRlBSD15DaIvRjlGzIgHy4rKJuG8/v5oPI1/0vuSjuvDZK7idsRylboxGcUwdRIFV1hEgdV8GfOLXiBqm0YN+EQg1hg+rmWlKjf853dG5bKbmufUQNmIrzokC1ERXK1QiwT1e6GD3zBeL8nYCOnxvmtmokuCmNwIGfy0//sx0hVEU2NJZG4XlIIISdxfQhH9w7hMrWxrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pgMNadtd; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pgMNadtd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y2Djx2nX9z2xn3;
	Tue,  3 Dec 2024 06:43:49 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2BXqsn019335;
	Mon, 2 Dec 2024 19:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ptthdv
	LNczidenLf1mjfjYZczot34nYiKDi3OMmwcXM=; b=pgMNadtdExpMF8d/t7Sfdi
	xX/81avIMgLTC6n2dkeAoOKcfkXtOlMWY1wuyQif0bAeg1YK+kOy8nZhChDu64uT
	4AWOymZH7L75W3CdNvk9YLqGlbl+laA8U848mPrLXfLpPzRVqsjZ/53RWUBI7adz
	qnukNNDe+v2JrAZXb02OhjOiWWiyIlpXOfpEFTV03DeUYCC1m08pV6KTr8ng2cQ+
	MEsPP0FLYXPO/5KPLK1bascKH8ZLj4x6QMoLTy2O2arjFpvkrWXgGrV+usRNeTV0
	ODVWZ24kHIHTmfyqc1B7K2LkBiZLUqQSqt6oTjjzDoTCbnV49c68Y8cjarcyI8lg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437tcvb7ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 19:43:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2Hu9vW006840;
	Mon, 2 Dec 2024 19:43:28 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 438f8jatr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 19:43:28 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B2JhR1R31326480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Dec 2024 19:43:28 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1CFA58050;
	Mon,  2 Dec 2024 19:43:27 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4738958052;
	Mon,  2 Dec 2024 19:43:27 +0000 (GMT)
Received: from [9.61.149.118] (unknown [9.61.149.118])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Dec 2024 19:43:27 +0000 (GMT)
Message-ID: <8896a6db-6208-4095-bdf8-f5d21b519631@linux.ibm.com>
Date: Mon, 2 Dec 2024 13:43:24 -0600
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
Subject: Re: [PATCH] fsc: Switch back to struct platform_driver::remove()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>
Cc: Alistar Popple <alistair@popple.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-fsi@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
References: <20241130150530.901263-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20241130150530.901263-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rs94fHDTTEC7yHxUvjUCMxju6vUxsfNd
X-Proofpoint-GUID: rs94fHDTTEC7yHxUvjUCMxju6vUxsfNd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412020165


On 11/30/24 09:05, Uwe Kleine-König wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
>
> Convert all platform drivers below drivers/fsi to use .remove(), with
> the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
>
> While touching these drivers, make the alignment of the touched
> initializers consistent.


Thanks.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
> Hello,
>
> this is based on Friday's next, feel free to drop changes that result in
> a conflict when you come around to apply this. I'll care for the fallout
> at a later time then. (Having said that, if you use b4 am -3 and git am
> -3, there should be hardly any conflict.)
>
> This is merge window material.
>
> Best regards
> Uwe
>
>   drivers/fsi/fsi-master-aspeed.c | 4 ++--
>   drivers/fsi/fsi-master-ast-cf.c | 4 ++--
>   drivers/fsi/fsi-master-gpio.c   | 4 ++--
>   drivers/fsi/fsi-occ.c           | 6 +++---
>   4 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
> index 6f5e1bdf7e40..0f66bc8ac2de 100644
> --- a/drivers/fsi/fsi-master-aspeed.c
> +++ b/drivers/fsi/fsi-master-aspeed.c
> @@ -661,12 +661,12 @@ static const struct of_device_id fsi_master_aspeed_match[] = {
>   MODULE_DEVICE_TABLE(of, fsi_master_aspeed_match);
>   
>   static struct platform_driver fsi_master_aspeed_driver = {
> -	.driver = {
> +	.driver	= {
>   		.name		= "fsi-master-aspeed",
>   		.of_match_table	= fsi_master_aspeed_match,
>   	},
>   	.probe	= fsi_master_aspeed_probe,
> -	.remove_new = fsi_master_aspeed_remove,
> +	.remove	= fsi_master_aspeed_remove,
>   };
>   
>   module_platform_driver(fsi_master_aspeed_driver);
> diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
> index a4c37ff8edd6..4ed2f33284cf 100644
> --- a/drivers/fsi/fsi-master-ast-cf.c
> +++ b/drivers/fsi/fsi-master-ast-cf.c
> @@ -1429,12 +1429,12 @@ static const struct of_device_id fsi_master_acf_match[] = {
>   MODULE_DEVICE_TABLE(of, fsi_master_acf_match);
>   
>   static struct platform_driver fsi_master_acf = {
> -	.driver = {
> +	.driver	= {
>   		.name		= "fsi-master-acf",
>   		.of_match_table	= fsi_master_acf_match,
>   	},
>   	.probe	= fsi_master_acf_probe,
> -	.remove_new = fsi_master_acf_remove,
> +	.remove	= fsi_master_acf_remove,
>   };
>   
>   module_platform_driver(fsi_master_acf);
> diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
> index f761344f4873..9f8bfc43ad93 100644
> --- a/drivers/fsi/fsi-master-gpio.c
> +++ b/drivers/fsi/fsi-master-gpio.c
> @@ -883,12 +883,12 @@ static const struct of_device_id fsi_master_gpio_match[] = {
>   MODULE_DEVICE_TABLE(of, fsi_master_gpio_match);
>   
>   static struct platform_driver fsi_master_gpio_driver = {
> -	.driver = {
> +	.driver	= {
>   		.name		= "fsi-master-gpio",
>   		.of_match_table	= fsi_master_gpio_match,
>   	},
>   	.probe	= fsi_master_gpio_probe,
> -	.remove_new = fsi_master_gpio_remove,
> +	.remove	= fsi_master_gpio_remove,
>   };
>   
>   module_platform_driver(fsi_master_gpio_driver);
> diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
> index a6d4c8f123a5..b5a7372a680c 100644
> --- a/drivers/fsi/fsi-occ.c
> +++ b/drivers/fsi/fsi-occ.c
> @@ -737,10 +737,10 @@ MODULE_DEVICE_TABLE(of, occ_match);
>   static struct platform_driver occ_driver = {
>   	.driver = {
>   		.name = "occ",
> -		.of_match_table	= occ_match,
> +		.of_match_table = occ_match,
>   	},
> -	.probe	= occ_probe,
> -	.remove_new = occ_remove,
> +	.probe = occ_probe,
> +	.remove = occ_remove,
>   };
>   
>   static int occ_init(void)
>
> base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02

