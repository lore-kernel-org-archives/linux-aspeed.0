Return-Path: <linux-aspeed+bounces-3164-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C0FE6689E
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:44:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFJJ61HSz2yFQ;
	Sat, 20 Dec 2025 17:44:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766148488;
	cv=none; b=XRwNQo/HY/4Y3IT15cCEdV/7JPD0MbWIXJmW2Vl2HzsaW7SEdvb59W3gRWfW25giTup1/WXmvJmDGVHo+720sl5k8U6/6aOtcsyO2mOPkgiuR8KbPMjgNGUv4Hh/80YMXLRfB5dgFBv9mQJLXjhjHbUbibIJ9ejQ6jgD3MGXFoKesMgbVSPZAVLhYNbWI0drJCCYCoAaFr1KNiyt3JucmIgPbfeyKHGfZod0AOvV+avlm5hVMODZFH+mL92zD934HcLE3iRzW8KVULnML3FmcGEbUd1dmCTscigDyHXWiYJeomI3wc4y8ng8/Sdx2LeJCmdTBXSqLv6Xpp0/x7TxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766148488; c=relaxed/relaxed;
	bh=tUolEG07YuA8naiVLt7C1pto13E5WsEaNtMVembr75w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BwVB3qb8XWtq5ZHK1XTKJh71xLP+6P5yXA+zXKoqqU88DarPPpjh727L3PbAZNBjWbsIsvYNd2zk83etGlEr8N2kywrHbVvFkiDdxeRdjMyIgdT0zX1pxgx/Ycs/tM83tJCQfqKCCyMCHQbCx96PQH8chEYsU+6AV9wTokVP1IVZjjK2ydVYfxRnuPLJ5Rs/aghzuShBI0qyveATYCneUtC25Eq53bCk8dlX+sXfyKItHMyx9UWIiD86hI25qyAjjiyPB/TrTAru2Ioa0aNj9TqXm2FL35PtZganEJnN5SoZcKYGs3ePfbYDTFpOm2DIOkVsnCHb/im3nIx11JZuXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ez6nQNFH; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Yoi0vpF6; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ez6nQNFH;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Yoi0vpF6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXnPz3tW7z2xfK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 23:48:07 +1100 (AEDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJB1ED84154540
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 12:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tUolEG07YuA8naiVLt7C1pto13E5WsEaNtMVembr75w=; b=ez6nQNFHtFElylYI
	CejLvYIDmesxKQNdLPRZrlOlIcLXgBTgBzymhItffriRO1rum38dJuyNDnlMVr5y
	dtwOYQ+5owUkXGrpp5lFoGvtcpJ8/qMaw+dcFPi41+DjMJtkFx/Kaj3wBY/o95xe
	7+/GsOv82CxskzwruoTS89fZ0tF0LkJrKgFik3gl3j9k7tFGUa53V1ZjiYYaQNLi
	JoaqVNPjVvwpBikY5MqQm9c9IMvtzq1BY5TCFtqbpM3bwMQ4lUm8+D45nC86KFk3
	euGqKCyNB2aCoEXTeXgKCEt/cUXsuJQiTwiVR3WnlTLlogkdw5LoVjjlX7yEJAn1
	VSKLOw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2ctkv2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 12:10:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4f1b39d7ed2so35974381cf.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 04:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766146204; x=1766751004; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tUolEG07YuA8naiVLt7C1pto13E5WsEaNtMVembr75w=;
        b=Yoi0vpF6Fjrj2ZquuJ8yzYUV3eO7pv7ZV0jMFqeiqLEbuE26InUbgViyLBO+Z7oIx2
         iKXAX0YXu3XVe+MtbJ3wUSd9rEY4utZSJ586umWMxcJ/jbsYiGn4QRswORQjEoYup/xB
         DjEzlHUx3jd/b6t9pJtsiGUlIN884dfau4182V+JJY/SDNW/nkveqIlOHrYhypZfxDTh
         4rSJ02pXZlTMVUkMUsih/nSoNVYR3IzhV6c2K7svbsQgXdTsxmCVCdT7iyhWuWz0QVTb
         vqiyNZuf4bjjx3voixeE5W3EGOErwVlU5mGmcn3igemjDVgjX4x+3QMe6ptzBSO33+II
         x1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766146204; x=1766751004;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUolEG07YuA8naiVLt7C1pto13E5WsEaNtMVembr75w=;
        b=mn3ZmLmCQG1hnhGyhqu3TEzO9LEb2fGixj1vrc1dZTIDoEybERzeQlADujOzgTnoql
         SODg95TFDZOsD19LXbAoeQSAtdmnT7PVl+HnA34PysM7vNt+Ro/V0qi84EWzaSStx3Au
         SH0nQwQk1Jn4OHUMDX3X/qUL3tialzqtAAWr8flabT182TlH+0eU2lmw1idYUv1uM3ne
         M5sLdTLVq/CRDoIJLU9rruK8kGDAE2Y/0V7AbynMFDjypUFIbvcL90TgzVtetf6zfnoM
         Jr7sKurd4H6uuOSa4i8caINKQtDgY/AJVmLPadrBxLi/jKAQuY3rGbUvU86I4qPJYYjJ
         zCvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZsz4phcaepZXjUfszzD0H4gjJZGb/4EjqnkrnuFpoTFhoyEBybeDrbN9tZhIvzwPq5Cy6dHA/Ii/qHoU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwCQhhjYWA0q/36uNilaRolfig3DwCxCHcHOjBvzml2XeQTXbhX
	V+/C8D2E6KfNwl3tyv4BGHtHiTnAXrUQvmSxmCf2DOzvBb4TfNcY9K1uZJu2RsB/cuoDLMyIT9Z
	vduhTgjDr+vojGCGonp0Ps0EPuiuB5uMvmLZHyTMFJJ7zfRUmR5RYEtTamU3Op3+LQGG+
X-Gm-Gg: AY/fxX5zU4KsyWAHRZx8Jt8D/kRHgXgLP726q49SAHXHfXcfDkI4o2RwrCoXY9CWCYx
	47ecCdNfugdMkmFKEeU5GsKpsvS2t/yWrFaGDUiW6iqGRplGKlBE0RqSzMVOnRFy8FyxJyO8A2Y
	Sp4PdrlRH826Bvu+nfQJungG8rDCgBU1PbUcF2/pcvyqHvidYSvDp8KOx6bJ/SqltklDfpHMVXn
	oiDv1vD4WjKZSQlHQ3dIIAcBrMvVcroWNeYeronFjITCuiVFVMZGkla25Bq90JqekwFcO4Lb0rt
	coVP6pJYbC63nzzHq5EFIRXl973xGgmbxQ9N5KghdgrK4EPPsy/aKcyAnu4b9Bg0V6ctRGBWDhf
	D8CZVK1laAaSdMMPJv4PTQjJ692bIGG9rdJNfBZqVf8PVuJRunskGtSzMsEq+sUIE7gS2TMjc
X-Received: by 2002:ac8:5745:0:b0:4ed:b363:2c2 with SMTP id d75a77b69052e-4f4abdba542mr36235271cf.62.1766146204032;
        Fri, 19 Dec 2025 04:10:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNHE8mUt1RqbOG36asJqPTyKdt2EDtPV/2sqLUBv01aNJ8HLkYsLaCnyAzQhCj8S9G+cl7ag==
X-Received: by 2002:ac8:5745:0:b0:4ed:b363:2c2 with SMTP id d75a77b69052e-4f4abdba542mr36234831cf.62.1766146203623;
        Fri, 19 Dec 2025 04:10:03 -0800 (PST)
Received: from [192.168.1.27] (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b90f53c16sm2024766a12.1.2025.12.19.04.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 04:10:03 -0800 (PST)
Message-ID: <c60ec8e3-0ceb-478f-9c21-14f9faa0b7e5@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 13:10:01 +0100
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
Subject: Re: [PATCH v2 3/3] gpio: zynq: Simplify with
 of_device_get_match_data()
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek
 <michal.simek@amd.com>,
        Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
References: <20251219-gpio-of-match-v2-0-5c65cbb513ac@oss.qualcomm.com>
 <20251219-gpio-of-match-v2-3-5c65cbb513ac@oss.qualcomm.com>
 <CAMRc=Md=KvKaXZvdwRd_rTp-Oq1qrAo12ENcUqTTWSYnCYSZuA@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <CAMRc=Md=KvKaXZvdwRd_rTp-Oq1qrAo12ENcUqTTWSYnCYSZuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yAYqOfRR6X37THk3iF6zxGTmD2fw3Fs9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEwMCBTYWx0ZWRfX/j57t0XaZTxk
 Q+Omhze7o4yZa2X6xcH1L/swnIi2DYKFFLoiXJofjgCPjPX8sl/GAyekSKOIUhCwzAfaheqWsXA
 yujSyZmng+BN+xMUUhfvIBMvFLh92Qs6sOeNqx0ElLsN+UC+ZSWnpTZfICyoq2A34OQriFVNadm
 tvbG8hiwM6FZY0c8lLGvqezu+3JSLnImg9a/WHKkKw2wIJjERY22rhD/Cssavx5GoduvlLgvfZM
 7m7iwX5G2T9h692Y/K0AwOjB5UrLhNF5BJseJVIrSiVidANMgBk1X+farag+uNvYMMtw4BpX7Wa
 xdmeAuoytqyZPOkVUPJZjiAruA79MogarO7n0VdyQylZujt1RO+se4zYc0u6JNQ4B+xT8bjsUQJ
 LRlaDlAZzEQL7zdViHtV5XV0o0hpO5jBWPO576G99KqFPcxIaCusQSrBfBattPNc66dqGYSUqC6
 YG0B1I2EmfzSpJmX+RA==
X-Proofpoint-ORIG-GUID: yAYqOfRR6X37THk3iF6zxGTmD2fw3Fs9
X-Authority-Analysis: v=2.4 cv=Lp2fC3dc c=1 sm=1 tr=0 ts=6945409d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=kcWgoHX1vMHs3kmCK-YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190100

On 19/12/2025 11:15, Bartosz Golaszewski wrote:
> On Fri, Dec 19, 2025 at 11:12 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@oss.qualcomm.com> wrote:
>>
>> Driver's probe function matches against driver's of_device_id table,
>> where each entry has non-NULL match data, so of_match_node() can be
>> simplified with of_device_get_match_data().
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> ---
> 
> I think there are some copy-paste leftovers in your commit messages.

I just did not update the commit msg.

> You're saying you're using of_ functions but you're really going for
> the device_ ones. Also update error messages. And possibly use
> dev_err_probe() too while at it?

Sure

> 
> Same elsewhere.
> 
> Bart


Best regards,
Krzysztof

