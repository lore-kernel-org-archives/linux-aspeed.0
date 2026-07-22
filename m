Return-Path: <linux-aspeed+bounces-4527-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35310C44539
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 11:06:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4rzc4Qpmz2yfy;
	Wed, 22 Jul 2026 21:06:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784708511;
	cv=none; b=FohWcLOvu782GFFCeiEv6y0D8AGps7sAcrxJY0NKv4/d7J4qbmlI0gHmL1LtUW/NLf9/2quijSlLqogUq1LeZYZ0pCqXeYrgmqVi+pifXyIssOF7dzfTIyGZAVyjLohClgQeAlHjEyGP55K87LX0dhCQ63eESL/CEY+t5twLDJA+f2XW5qX0qy892LqrAdOlPW46lFaHKxorxJh6uAgLVhbvI8IPVBsI73s8dWDzQfZzrhsX/s78uBjTZDNPOK34EV9fhEk761DFt5XnJmv8O04UX1Oaj2Efr9JPCRCZUo3Iaf3JPKg7yAOExmyx4YHxMK3Nf1WqzpJj0hkgYMP0fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784708511; c=relaxed/relaxed;
	bh=qHQZ/CWxA22Mv/04aBv8o7hR+RlYHT5Vmjk9Hg5QZ2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVAEpo3zu8UKQ6f0Y3IJjzrf9RzJr0xSgXcULpiUHqq8plqZRyr/tVMufaTEH+nnj13i5IX3GzAtiAVWlVSmYQxcNTsMcAjz6pv+12WrbD1dYHI315+uM4J0bVfxU0Le3U+D6PN+BKz6wkorHIdonKXrxe+iygoeW7nv2W3p5UoRrWCtOflO0IZMB7fmGfxR/mYHaU77/iIxq+35rATz85lr1GhhtcL416jjmfjAV1sGnSlvYfX7ok/NiO5o5JlC5AKOvU/Ykhqj99UNCVv4oSmNU9Bca8ohkI5rqXCdaMKKiJyg9rBpo5yerNG8AZ5LyQEuqYwTc9FWwlEFvpvRUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bjpK3QtR; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YpCH9BAZ; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bjpK3QtR;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YpCH9BAZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4nKV25dqz2xLd
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 18:21:48 +1000 (AEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M53kHV3787289
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 08:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qHQZ/CWxA22Mv/04aBv8o7hR+RlYHT5Vmjk9Hg5QZ2U=; b=bjpK3QtRveDeMCC2
	K/RlkmR6v7hFM4AQ4nfyr5xKqFXdjAqgAQ4PpbQXMDBqjqGDS6LR/4s7nVJn5VXt
	IeGtUyLCV0Ht/eAgcnkSCpeWFkeEFXxS1KFTbDtmI3ahSEGXPI000LLSh2kXpbwE
	Pf+h2TGWfwXP4YJT5JWwjuJuxsEvinU05sqBfiU7ohAGo220zrImzGxyTO7WZMPP
	yZ5jDkqz0Tj9g74QLlidBioGgJ1yaiXUrq07o2WKoC2aGR4St7MpVuqn/GJOihyS
	akS+zBYi38aF4sP5vCdGEQpcYxx35z1aJUNws17dFDPOpu1HEoLpdGIY+NHJO2A+
	pLZpFA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9aecerg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 08:21:44 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51ebdfceddcso152258991cf.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 01:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784708504; x=1785313304; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qHQZ/CWxA22Mv/04aBv8o7hR+RlYHT5Vmjk9Hg5QZ2U=;
        b=YpCH9BAZu9espuHi7GQxAeiBIY5CSIJ+sMP7WyUMszOZNtMVH3BT4xB5y1806tsJTb
         kB8bZo8dqiohWMjciABo2B1jXit3jhJk9qsUns1OS+Xea1V83AT8jCACWPwEVnBmvbUl
         LtJnqVtEGOE3vIm0KL/AjttO/dTcA/WwlrmO9aI+5VLpEKbqPnbxFMRKdDI4DRNoSGan
         EO2buNo0yFywR1AFJKSQCLRiQnIzqsfZsUB2mbLB1Xj6irHXNEHfFGLpcj77xsSV9XFG
         t583tP1IUmW4i4MjqjckJGOQfZibUkfKEatLzp6kyC/4v2fFLyGDVlyiUdPpEn3S8CAg
         eW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784708504; x=1785313304;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qHQZ/CWxA22Mv/04aBv8o7hR+RlYHT5Vmjk9Hg5QZ2U=;
        b=bon0SvyeP4pHcaB1/YeEwkQSybaMyMNf2ElqMZw/Wo4uzghPYEjtl6602O369grLen
         fN6/epMQOYNkjReq3uo4cNhemtbLD7WyfxdDMkyFv3/nTmFoPFH5w3dq2i4KK9ZulVzb
         DVBJxZYcc/d3MV52VjVCDSpsFJ7IUSmL7f0qYQPYW+vKUWzUAZuU901I9x8cNfKsoYiM
         UybbtBxoRtsTnvO8QTJLOgB803Ufh6L9ZP99HrBg/F2Wc0oBNaD+0B/Rsxz+CBmRcFHz
         E8mbYKVv8udHRPtwx29TminUGKGMOjhEuXJBk1efJU/MXVrK7gniksXxPzloA2wT1Eff
         4bZA==
X-Forwarded-Encrypted: i=1; AHgh+RqaFBnpVBvvrWl99Di/6I1pbLpCJqgJeQTismxYImsI2PxOmLj2bwYCPg4LsiPjBE9pcmoiVb/oF0KOIRI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxRBWnfCEfVtfXDudm0gU5299qPAXru0vHp0ZiG6471dknp1jnP
	Kz24Sb9n/79nO1dnhyhwPYaC1C5Y0zEtS/3XlqRckvHCW1l++2vyiNymr2+XOmUk2dbPPinTtQN
	v5YuUKxXGqDq9/CBpuoDm+c9lwtYIkXJqzeCF9QYh+129LY3USzjBbPgONW1GhXHFOjE0
X-Gm-Gg: AR+sD10Rg+ujzf+NT8q2g1GbBjslKGDmOHsAfr6i/lzRLvmEuDv6YVMpHkxbFP+2YvY
	Mw2B2M8g9Jm2b+QKA5OY2/M+Inq3823YwZrjIW7OUZtZno3mbCDZP3P3E91ZE+tIIs88AzEoAX3
	ZMrnnARcbvUP426msgS0LLbdO+SYEEaD/TjRExH22+K78fRpIBE9wokkfSCeGZ/05UiG5LzM3Pa
	esqY2HOF4kaCpH2FFJAhqpwQEh9PfJjqld/5xsuIH5WSKDHfzSx54i1916pfGgc2n5FT+EeYB7y
	3gyXP0UmLs7ODh9LxvTQqbRdseas1JBOnOETA1amhej40he10+dffNqeLxLdGmDTDzgRFJBvp4V
	3BMxu360o6A+oOJ1jlQClx7HpA2SbIQ==
X-Received: by 2002:a05:622a:1a94:b0:51c:1bb9:137f with SMTP id d75a77b69052e-5213c20160cmr208790891cf.24.1784708503677;
        Wed, 22 Jul 2026 01:21:43 -0700 (PDT)
X-Received: by 2002:a05:622a:1a94:b0:51c:1bb9:137f with SMTP id d75a77b69052e-5213c20160cmr208790591cf.24.1784708503220;
        Wed, 22 Jul 2026 01:21:43 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm3735346f8f.11.2026.07.22.01.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 01:21:42 -0700 (PDT)
Message-ID: <3523fefc-8ba8-4512-b088-7a94a2df73f8@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 10:21:40 +0200
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
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ARM: dts: aspeed: Add NVIDIA VR-NVL BMC
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
        Jacky Huang <jackyhuang@nvidia.com>, joel@jms.id.au, robh@kernel.org,
        conor+dt@kernel.org, andrew@lunn.ch
Cc: devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
References: <20260710054849.3178747-1-jackyhuang@nvidia.com>
 <20260710054849.3178747-3-jackyhuang@nvidia.com>
 <b707f061cbdfe52f8d72ccd33ec177113e20a5e5.camel@codeconstruct.com.au>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b707f061cbdfe52f8d72ccd33ec177113e20a5e5.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AarWFJ4FwLHAaEH79NJxCZQkPsoWSPHf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3NyBTYWx0ZWRfX1m9slDq6WaeI
 jcHcrjaWQe6szmiYUepEQdpG9AUUZa5N3/+L1vtH2impvDAr3H+OjtCiBzGEuEmM2AFvb8naOHR
 GXdAGyyqutQp5lqfVPnTf9FgoUW3q9Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3NyBTYWx0ZWRfX7U+W++Hz5t5b
 SZ14MMTAHkRvBRSTNytjz+pAnYQm8gtx6vaTB/wA0FbS1GaW8AOH5dFNQpT6L+xtlQKy0yT7Svd
 bOxJO5SA2+z/yTdgdsNwRmntzzZiPiobOKOaQpNODpx0dyxdIYD6jB/G0rnyPn5TOwER9+hJC62
 aO0OjeOUStKjYd8B+G1GxsXolNRZwxq2WkLOFoivtDYzX+dFmMlNJb4QObW7IirdWyU62G3ishu
 GLwFlkbZ5VoZppXysuRtNugakFlczJwhkqZARd5P6SXmCmj48cyUOq9n16nEUfGYzItuDV0mGlH
 rQS+49LRdX2AYoc1V8Z22fzlXSfE8nLJIwPnjkqcra/sybWH+afTdldtg6vCeBQdLlmNFr10Qa4
 eWNb7EGZCC8QiizyHujhCoSD02UxskLQotJFP8UBCmB1mHW07gCCo+QNwCs3IBq4iisr/BH73R3
 C/xRukwvD7eDO/+0qPA==
X-Proofpoint-GUID: AarWFJ4FwLHAaEH79NJxCZQkPsoWSPHf
X-Authority-Analysis: v=2.4 cv=Cr6PtH4D c=1 sm=1 tr=0 ts=6a607d98 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=aghwDrSpn70jpU0UxqMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220077

On 22/07/2026 09:45, Andrew Jeffery wrote:
> Hi Jacky,
> 
> On Fri, 2026-07-10 at 14:46 +0900, Jacky Huang wrote:
>> Add the device tree for the Aspeed AST2600 BMC for NVIDIA's Vera
>> Rubin NVL compute platform.
>>
>> MAC0 uses phy-mode = "rgmii-id" because the on-board PHY supplies
>> both RGMII internal delays.  The matching U-Boot device tree does not
>> enable SoC-side MAC clock delays, leaving the MAC internal delay at
>> zero so the PHY-provided delay is not doubled by the MAC controller.
>>
>> The corresponding U-Boot change has been submitted to openbmc/u-boot:
>> Link: https://lore.kernel.org/all/20260629105202.1417679-1-jackyhuang@nvidia.com/
>>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>> Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
>> ---
>> v3: reword the &mac0 comment per Andrew Lunn's feedback.
>>
>>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>>  .../aspeed/aspeed-bmc-nvidia-vr-nvl-bmc.dts   | 901 ++++++++++++++++++
>>  2 files changed, 902 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-nvl-bmc.dts
> 
> We now have scripts/dtc/dt-check-style, and going forward I'm asking
> that all new devicetree submissions pass in strict mode.

Thanks!

> 
> Currently:
> 
>    $ ../scripts/dtc/dt-check-style --mode strict ../arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-nvl-bmc.dts 2>&1 | wc -l
>    152
> 
> Can you please address those?

Just a note: --strict might not be ready yet. It reports some false
positives which need addressing (I have plans for this, but busy with
other things...), so expectation currently is:
1. No warnings from standard mode
2. Review and investigate warnings from 'strict' mode, but do not fix
them automatically without thinking

Best regards,
Krzysztof

