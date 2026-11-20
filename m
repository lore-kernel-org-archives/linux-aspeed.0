Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4FF606A32C
	for <linux-aspeed@archiver.kernel.org>; Fri, 20 Nov 2026 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nVOlxK41
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWKK657hCz2xpt;
	Sat, 21 Nov 2026 02:39:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795189194;
	cv=none; b=PKkYaZIpUs19cCYQ0mzqIr4kFCiP2WoB2s93Zw7ZN11+WVOPZyRAMvsPsyUd3Sw0fw5c68TOxo0xKGbQ8upq/0yz2S7LcUDgGT95+E/qz++EVDn+Cqd1PaxV2RO/w4Mz/GvdKgaSOlh9Q5ujNzhTtpwAXv5I2eDS1/1DjyvUU7Qhdhm4O4Yya+prlCRL+SrzYzEEBOJe10OoaHDiVh6SUniWtHfn6NMpovyNrIyP58CQT+dGrOVSBeRLWQiAY9gj46pmbbLWCgU46UE25z3ThjJz93gVGpiM1zBpMfG1uH8GBV57ieeumbYVdRgnJ+NUl9pzuh4RMCYrlxJ0+aTd7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795189194; c=relaxed/relaxed;
	bh=vmYG2CzA56D42MyndsHp83p6siaKz1u7RqN4C013/tY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aeEPxVnOZgAI5xEGtbDe1+ApICKP7CYWcuMArONM2Q/2vfxhBYdjSSf327ac2UgHeemk1WqDNlOGm8+9oeYRWuVIiYrpamjsjIJ6RAIOp8OnX8DJEdRg2q5RBVtvZvPQQFlEazyDeD8ulwU/nvqVHaruVaiFsrQLe29cvhqpcutKSZpe1sb8kfHAAeSVg1JNjq12qCUTSz2a+WRSqBYSPshOgHjHFuEynepKxmcqYMzIqw89/TZdTBAhUPwQiJCbpBP3EAE+cCs9uaXa7x6crCiCtdL1FHQu6Z0qtt+q5PhhUUKGcLBG2vydFfqUku/R8M+6+qu4UYdezyqx03tBPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nVOlxK41; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nVOlxK41;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWKK56RfWz2xmh;
	Sat, 21 Nov 2026 02:39:53 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKEuWlh3423804;
	Fri, 20 Nov 2026 15:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vmYG2C
	zA56D42MyndsHp83p6siaKz1u7RqN4C013/tY=; b=nVOlxK4104buOQHMGgDEQT
	+CS8pim7LGlwSOMkHe4CJro/72TxbBfSjy0gBO7OXxBrn6h3xKo0qdnRwREDrvCe
	Ij33Dfr2noKC2ah5OJg6R5ZyRwxFohMM52EKyIqJmhFplCWDrLdprWdrVyAlzJ9X
	hkh9Soe1Z/ge1JqRifFVUp/PRu0CUHs8nAgLEu4v2RCV4h0Engq1MQTQFEFelCzn
	p5UkmA8td1bZWPSqVL2HEfJEpK7yvR6IXLVypCYMQY5L4fYMKJ5tmbrbS/2Tlvda
	CDwyYiqejG9U9ahhj9j3OpWd2yxznk2dlllML9E4Lbc1CBHh+HeN5qoTALynRGwA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105w1428-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 15:39:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKEnuK22445442;
	Fri, 20 Nov 2026 15:39:28 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1m3j2xac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 15:39:28 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AKFdSiD26280638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 15:39:28 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F51E5805A;
	Fri, 20 Nov 2026 15:39:28 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CF9758054;
	Fri, 20 Nov 2026 15:39:27 +0000 (GMT)
Received: from [9.61.14.72] (unknown [9.61.14.72])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Nov 2026 15:39:27 +0000 (GMT)
Message-ID: <84bb623a-151e-4f6d-ba6a-a303838f4aa7@linux.ibm.com>
Date: Fri, 20 Nov 2026 09:39:27 -0600
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fsi: aspeed: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Ninad Palsule <ninad@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai
 <billy_tsai@aspeedtech.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-fsi@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20261103-fsi-aspeed-gpio-nonexclusive-v1-1-1fb040c59386@oss.qualcomm.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20261103-fsi-aspeed-gpio-nonexclusive-v1-1-1fb040c59386@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EWHHhtBzh0nmcbaMz1EfwNJyLAH-95S_
X-Authority-Analysis: v=2.4 cv=HL9WhYtv c=1 sm=1 tr=0 ts=6b0069b1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=zmo_udYM6pYQbqL80pAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EWHHhtBzh0nmcbaMz1EfwNJyLAH-95S_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2MSBTYWx0ZWRfX60wzkTj5rCZJ
 Axp/ATwXoOVTf231ZzOlUdUiZUAlIBZdfQMOAmGfXQ2dvcsy/YBaJUqo0K8t9mOl5+JrO33w1w8
 Y9ZCfqsKSN7Bj877H0NzJ53ypLiU5RqWwIrfY1v/tbJR41icFDyGWQy2Gektlxz/v8rlX3mb4Gt
 fdRVL3dhNMKnB8DmOuOVDRAN4YAk7HqhhPrDDMFi0XTZ5eAB/2Ela0EmGRZ88Z3zQ/IZJEC4D9D
 Mn3/9qR9vEzdHuqEfB4yqzRlFBXWLSfYR1CRpdlHzfujRynLiR5//oRn9mS4Y11dRs4MFM/cXDJ
 JG76PmEvIt1C0AcJ6LCf2MYFifVvu6ZA4FKm0vOeMkrUvU7PwyeHNerinxPq2aNYTcKpGCBa2O5
 Eh2XKt3yh8lvYSNwmRaTQ6SwxiNCbxv/HRl1NRdYpx270DCbBAOXKMf+Hk3K2JQMUSC+njqOJDG
 Pzm52nkbQ0wkQ2zMEug==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2MSBTYWx0ZWRfX9eGEl6ytv4s7
 wRpaigFbRZJwJrVgeVPYOcNynpR7TXt1RMCqBZsHVJeMNhIOPpy+SZcgBlLayV1NIs4pWoaEBLw
 fj0J252ZWU7AYhsJue5whGe9rcUf3tA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200061
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/3/26 7:20 AM, Bartosz Golaszewski wrote:
> There are no users that share fsi-routing-gpios in any of the upstream
> DT sources. Even if there were, the right thing to do would be enable
> HAVE_SHARED_GPIOS for the aspeed platform as this is the preferred way
> of sharing GPIO pins. Don't request the GPIO as non-exclusive as this
> flag is now deprecated and will be removed.


Thanks!

Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>   drivers/fsi/fsi-master-aspeed.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
> index aa1380cdff338dfef7caa8d516322e6bf90371cd..88a3a90abef9cd22cae03f5666936ef7eced8a7d 100644
> --- a/drivers/fsi/fsi-master-aspeed.c
> +++ b/drivers/fsi/fsi-master-aspeed.c
> @@ -496,8 +496,7 @@ static int tacoma_cabled_fsi_fixup(struct device *dev)
>   	 * The routing GPIO is a jumper indicating we should mux for the
>   	 * externally connected FSI cable.
>   	 */
> -	routing_gpio = devm_gpiod_get_optional(dev, "fsi-routing",
> -			GPIOD_IN | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
> +	routing_gpio = devm_gpiod_get_optional(dev, "fsi-routing", GPIOD_IN);
>   	if (IS_ERR(routing_gpio))
>   		return PTR_ERR(routing_gpio);
>   	if (!routing_gpio)
>
> ---
> base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
> change-id: 20261103-fsi-aspeed-gpio-nonexclusive-3dda6d175968
>
> Best regards,

