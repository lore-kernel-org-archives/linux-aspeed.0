Return-Path: <linux-aspeed+bounces-3918-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AE3F433D0
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Apr 2026 00:11:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwz271zNsz2yrT;
	Thu, 16 Apr 2026 10:11:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776078837;
	cv=none; b=UpPCJp5tFV0p4nWLIw3SCir9MP2mcc+UPjB056eRrenzuTGecibJWSq9JAPEC/iZN5uYv+BAH3gxEXpLiHyBfERZKGH8wXo6GR4STV1+C1i+FWNMiLGneASOnVr18OaBYPolBx0dWiN6TMyWzhox4JY0V33YwhqfkvBJnZen2iCzdI22b0YsyIu3hLwX3yJVESj59zMnrlPNhHDTHwR2JrPe8/6PJ/OzDwu1hCbhEaGVgD60sDnwTcunTMsby7qzjlrGiAE4GLrh3dOUZuxb5LghmpD+EigXSo8bvKyT/So0upUyEWy610nB3M8EwFz2nYgjYI2hDSMlRHVTRpmlkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776078837; c=relaxed/relaxed;
	bh=tMGTprsrYzJtBsOHJOoosmNqvDj+crbOe7chA++pxYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HLLUlZUbIucOm3eaOp9oFJVurkSC2UDQX9g1FKhoHv32oRL7QFEZ2dpiCts0vAaJakNqpCtAH09Drm7z8TofYxxPgiHFdMKhix1PhGCSzT6Z37OfmUpPZsoK7Xk3qNXgDLOfUSNHYVAOJccmwOIegD1rH1jImtdXXs6LK7tWngQ6y1/tbON9hHkvdoKzrvcLATOs3NgVbJLUVJixkReAJazxao3E0SkR0nPm4JJszd21UwMhdpVLQ49XdG7Ui9vz0Pluv4j/n+pUq0oEp90w/NNZ7lRuLoXNrUomq9xwSBv4XDu1ehPgSBWn2LDv8+JJt+fCzO5eQJJDvirRJUK6yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FttCNoqP; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OVttm54F; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FttCNoqP;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OVttm54F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvPtD3DZkz2yrt
	for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Apr 2026 21:13:54 +1000 (AEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D7ttUX3974426
	for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Apr 2026 11:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tMGTprsrYzJtBsOHJOoosmNqvDj+crbOe7chA++pxYk=; b=FttCNoqPV+itb35Z
	mfcL5AAIq/LCY7Xw+bBnFRY4EnbcWYDp8Q3RhW4YV35rOVVtqW0Reis3uGp20w2w
	VH/Z6/KxxNknEH7Yv3q61qZJja5PQSVhTWF9zwa7cuxiEwUXRJD1DiwJwUEGFVot
	XnmlNoFWRybWWzetHoaNGYa3NJnIfrXii/itUj3Nn+LAGiSwSqXD3NEYjb/rNFPr
	/nyGYjII2m0fGyz72hjl8bSUfyDvd8zZUkdJEAgEKMPOLx/sdUA7yDVAxQAup+nD
	+lhX5I5IlDrXwhpkleRuI736mAje9K4ri/nKPX9DGI4bCpf2YsBfeKtd2rLD16bN
	mQdzEg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfjbpcq7c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Apr 2026 11:13:53 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d9d52ad9aso28616571cf.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Apr 2026 04:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776078832; x=1776683632; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tMGTprsrYzJtBsOHJOoosmNqvDj+crbOe7chA++pxYk=;
        b=OVttm54FBMnQ/FqA7Nm6x/qbiNOFCq+0ewb9J30vq7sEydRPItFZLlJ+0xE8wplIZj
         qnmogoHTQvNexyf1xldCGzja/ZneYNolXY6i2AK1w4OSFVjfaMKoCDWohZe86uqDaGvD
         bhDIH4Rv8AqgXMrwrQHEO7Lg0Y0ZUV4KjlROXR3Zt/4Wfg1KYo8UYIWno2yhWrYGYWhd
         gDLtIQIBBJpg/00ORUQesEHA7wEj3JxUWw/ggFOJ58nPPXKDai2zd/CHciFI1n4zE8mT
         GRu7GlBBfRVZk3nTWVnYyUf489JjIK7skVvXMjdvuuM+fYCgwX/2uVZnFEkcDXl05bH1
         AlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776078832; x=1776683632;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMGTprsrYzJtBsOHJOoosmNqvDj+crbOe7chA++pxYk=;
        b=Hkwt7IjFZZg6O6iA/DRHKNcG/iMEa+bFI1iLZ6RpDv2bXiNSKfAlWhAELYFzx7tjbJ
         +0IxWWCrMt7sYB8ZTCeK5C9P9qU3+KUgiUSg4m4Pqah+kn4BPxzgBZyVlIhnxE+0CmF6
         cQetGtigiOFqBPb/5gj/WKxu7YpSghvziGbFm8i+A2ovyw8prunCOyp0YIAKQeVcn4TH
         Xr8UrsuGLw08yneZ576XPaCHLe/3W089JipqOzaI2F+gzeuxzXVResY159rAHttpHHHW
         7sWFQpEh4AoyAqI75DUFTxBluhv0Jgun9V+jmGnxPDTQTBPkrF4Kb7WPYLzqRZRwDVjk
         TIaA==
X-Forwarded-Encrypted: i=1; AFNElJ9hFjK/QQVcK4S5bjE44gXXEAPrDiB/KDr3HARE5j/aVSUScYSfbdO133fp/gzYPStr3yrncDSHddOASEI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzkMeJ7dZCU/kupw4VEBuwEEqqoe/qDKOITSmIK3CpFk9RlVT6i
	KG1AARJnlRYblwS7x4+jlYmaRIT3iJHMoetaE/9hAyySA2bNQCJ6ayEg6H09rw312UE1HK+sR3+
	QoH5B1eJT78OPuF+cFocxPQO1oExQilKAzsZpEjkN79kt4PyWN4GyY33BGGwplysy0nbs
X-Gm-Gg: AeBDiesqkDv69PuLn/7N2onelZyWTtcP2HxvgR8/YmOrTgypES0gOnZuFnLUSTuQMFS
	mYWo7xixLJbfE2V6bUWDAm7ldPMcqDwTMCRQ4o7OIx7u1C+bc4cFEq7XJQMWahuRRgh7ehTugnt
	/xemCXQ4VQbWq+PMl9QQcm14WvE+YwDB+s1iMAfTUiULFtQnhAAadZD5jdqLQNQ0zmEiONsTNdf
	GKQwB8W6PzOSjvL7VxwCuoztAZ4bm2ZhNG+gQPPg0VJvZv32GTE60L2YbQfj8198PO1trMgYc2Y
	ly4f4G8ALI99Y6CCkH0uuuzU7FWh1QTiL9S70a+jSY5H6z6jEEvUr0VPmRIcJCAkd+CGSpNkv+Z
	8WoiYijrzH5OF0qEHctNsTFqpIZH0MFZZd+rFQgNKqEAcXDmC
X-Received: by 2002:a05:622a:a916:b0:50d:7f66:dca with SMTP id d75a77b69052e-50dd5baab7amr157673011cf.33.1776078831904;
        Mon, 13 Apr 2026 04:13:51 -0700 (PDT)
X-Received: by 2002:a05:622a:a916:b0:50d:7f66:dca with SMTP id d75a77b69052e-50dd5baab7amr157672681cf.33.1776078831464;
        Mon, 13 Apr 2026 04:13:51 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d6ffd3880sm16502298f8f.7.2026.04.13.04.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 04:13:50 -0700 (PDT)
Message-ID: <e483acb6-af9d-4bc4-9aa6-c4841ff0a8dc@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 13:13:49 +0200
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
Subject: Re: [PATCH 4/4] ARM: realtek: MAINTAINERS: Include pin controller
 drivers
To: =?UTF-8?B?WXUtQ2h1biBMaW4gW+ael+elkOWQm10=?= <eleanor.lin@realtek.com>,
        Linus Walleij <linusw@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        Joel Stanley <joel@jms.id.au>,
        "linux-realtek-soc@lists.infradead.org"
 <linux-realtek-soc@lists.infradead.org>,
        =?UTF-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>
References: <20260410-pinctrl-testing-v1-0-6f708c855867@oss.qualcomm.com>
 <20260410-pinctrl-testing-v1-4-6f708c855867@oss.qualcomm.com>
 <45866135c8a54e1d98cac51932ca8e1a@realtek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <45866135c8a54e1d98cac51932ca8e1a@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PuijqQM3 c=1 sm=1 tr=0 ts=69dccff1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=n9Sqmae0AAAA:8 a=c4pGgGm1PQYjHLslJMsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=UmAUUZEt6-oIqEbegvw9:22
X-Proofpoint-ORIG-GUID: M06ulAW7Jz72ORswycWzhaJicrrjW7zv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDExMCBTYWx0ZWRfX5TINaojOiPld
 MiWSCVmrWpOi2zKeZFqQIDTrlr0SX6B0GJJ5IeXwoCoNQx5sqr9diKlxA76jj8G3TlZ0sj0XuVc
 0U3naH2RiisVeJpxoxavbGb5Vme5UdqNQvxt53cEhRnrl9gU3jOa9TLgqj/GZGn4Kw6t/B39Gr5
 WwpgO6EV1ZiNrQLT0cYjbaFftPmJQ2Y2o1JOenpuRqpQIJ5kvB40SZYK192xivYxz/5lD43ph7z
 L1uw7uyMiD58vmaLgBQOccMFWPjRvAA/+DD6tHPjFuGUmxDcDj0tbfrjVyGz9mxh3R5VTS3PzRV
 hYaaqFJsrUrZAtcCgkR3rqDjB2nDofaSdSZkAAQzCtRBzgIMUHoh1oa9DmXXmQpti02jLl0fP2q
 UIIfHORlg2nMW0vQ4mjqIfDGwJyddfskG75U+cw33FpTnqQgxDhsx/PVMwOGheI9qOm57Hm6C7q
 4EGBSEQDw3gTZdSVbkg==
X-Proofpoint-GUID: M06ulAW7Jz72ORswycWzhaJicrrjW7zv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130110

On 13/04/2026 11:23, Yu-Chun Lin [林祐君] wrote:
>> No dedicated maintainers are shown for Realtek SoC pin controllers, except
>> pinctrl subsystem maintainer, which means reduced review and impression of
>> abandoned drivers.  Pin controller drivers are essential part of an SoC, so in
>> case of lack of dedicated entry at least cover it by the SoC platform
>> maintainers.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>
>> ---
>>
>> This patch should go via Realtek SoC maintainers, not pinctrl.
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 10d12b51b1f6..374ce55e4fb6 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3373,6 +3373,7 @@ F:
>> Documentation/devicetree/bindings/arm/realtek.yaml
>>  F:     arch/arm/boot/dts/realtek/
>>  F:     arch/arm/mach-realtek/
>>  F:     arch/arm64/boot/dts/realtek/
>> +F:     drivers/pinctrl/realtek/
>>
>>  ARM/RISC-V/RENESAS ARCHITECTURE
>>  M:     Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> --
>> 2.51.0
> 
> Acked-by: Yu-Chun Lin <eleanor.lin@realtek.com>

So James will pick it up?

Best regards,
Krzysztof

