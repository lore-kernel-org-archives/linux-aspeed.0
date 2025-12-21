Return-Path: <linux-aspeed+bounces-3192-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB83E67495
	for <linux-aspeed@archiver.kernel.org>; Mon, 22 Dec 2025 04:56:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZQp001W4z2yFY;
	Mon, 22 Dec 2025 15:56:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766325951;
	cv=none; b=fCHw9zf78YelvguGBawVgAMEp5WlGuCS9pqO6lfcyceEVAHdtIHjJl06PF71YcMQodvnN2M6BBSlBgHlOZuX6AtlAS7opon1DK5XDX3imiQtMfLJbFUVqO7L4azEySgiu+cwezo8Wqi2hDFOVpX55HP2Gzdca5Y0/EzCCE71yxReiiH9MWUmn3rF2Q2lLdIg2l3p9bQ3lfsjgp3kC7aFhVmATGj5FEp1ZaUxBk7r5ftLJAkkxfHrv3CGBuV3l6hfXuXtFAy72gpJ/mtrQhaEA/vpET/ETSqM2zJlM8+xA5H9/PEG2WdxDu0yFsFLq3FJpV34L4tcZNPAH7XRAB+Dsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766325951; c=relaxed/relaxed;
	bh=ihJ+Ec5j0Wj03PL6tGf390iLLMIjjv5jteMD9vvDTUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZoIdz66ddPMjlJNf2w0UVBhD8xpY15e4SuB6bfW3obJHnbFnoE+Id2lDeku3KVjhRumddaKfDJeDKGrh9fC3ObxJR0Js1H27MvizEWz67YXY0Sea6cX+zMQcRMpBl9kGCi1hzjK2u2MeqUkgjvRP9BjBDsG7AQOX/pDWV3nJpmI7ilOWTFfJUwS6Q6KL7DO4VKoCZHf2a744x7tY/lVKEMIMOVGVErse4qUuGqmScPCya8ZypmdiNrMmqcx4jJe9sLVqWcWlJn92wI+JFAi4zNqoC+B4biLYxAhVMw3jRBp02M01TnJVXQJ5U6lz4zMTwJHzSpuK91uMy7EQizlcIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l3KIxPl5; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R7gLD++A; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l3KIxPl5;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R7gLD++A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZ32j4DkHz2xQB
	for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Dec 2025 01:05:48 +1100 (AEDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BLCMAQe2517523
	for <linux-aspeed@lists.ozlabs.org>; Sun, 21 Dec 2025 14:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ihJ+Ec5j0Wj03PL6tGf390iLLMIjjv5jteMD9vvDTUQ=; b=l3KIxPl5kIN4xNib
	myQ4HNQYCI5ceHdtPJpnvoXePGxZ2ALz/v36TDFMiscfK2cleq3yWzGnv4yA1sFz
	XzVlg00q+fnP0eOssShHUZbtAyANXY0sTxsf45OiR8JHuq7YBh4iVuLP4MvLZj61
	LG/rmLO/tsthe9Zz/dyeM57m8s3JY1ktS9dBgJQsRWKdKiU4a3TgUvIkZ4LG8XBx
	3F38pHhC6QePZMfGY6dtM719T7/4/22pIk3nqeskQ6XofIQAoGDrq5TidY2Wlhsh
	rNRzIM+WbSWJrCL4GngMPsmpTWGT0SczvJllVHHqwKsTx5oKQvCp4rtSDE+Z2v4D
	tJplqg==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mrtadyv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 21 Dec 2025 14:05:44 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-78fc790162bso8693337b3.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 21 Dec 2025 06:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766325944; x=1766930744; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ihJ+Ec5j0Wj03PL6tGf390iLLMIjjv5jteMD9vvDTUQ=;
        b=R7gLD++A3WvWQGhEB3ICwnIwdM9knsBBs8PmRrG5hQ/qWtfnIGCtWxR33K8IkiWeQ5
         NRX4csSTAhgs8dKfraawmTwuBG0ipMkrMzLkzFbtUV+EqlCqY/Mb0wz52JVJyuDCjDds
         wI6Y6DwaRLlNYODFqEPNU924t6rDbNdui338kF+WaWmYlk/IH6yhq79TYhJWHiRegv98
         oeYVrLKBbYlIEuuZI99Tb11YOusl1+71t91XPQXXj2brUr15/K4WvEBPRui3vwu952Y/
         Kaq2kJuWcQIYT+FcR/Zixu4mpUlLPhGC9Oqkc7AEDKnQuHfdRqSu/fZYC4uGmYUDDCdi
         Jp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766325944; x=1766930744;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihJ+Ec5j0Wj03PL6tGf390iLLMIjjv5jteMD9vvDTUQ=;
        b=tjcrSlkInBox16GAdnR6m0X+Pj6XrHr3jBCMc6yVOxXUHLdgQ1OxqyTK6e+6VVwzXT
         2xcrS1olvHiGdd2HPH3R3+OYnwSYazSCIUUQdUBJ9GKt+WWhAv9nfe7/XTHLFYjSoowz
         tH5ndqW1tPjP1IOCupo7aF9feddhwTAxaMf4UIRUhK4byw8FKSLQ/hVnX/9ODSPgQRDO
         7gBjgZOgf1ALEfBVvDlPEUumDeEHRsFMsPPjpO6xuwhwWcgw5slkV2pfXKbHzu/7Wzgr
         uh51J8PtJMuVX7ppsNrPMUrLiJEAwV26EO/NYrKS6StR0Wl6/Ds26xyCPHUNYVvGh3Qj
         HOqg==
X-Forwarded-Encrypted: i=1; AJvYcCX6FHWjJeev5PrRvNUGeh4ANYOiJ5/kS/e1qvrnFa9Fd8/1+abE4BPKlsIy+CgabQH1Tdynbbm0W9HIsu4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzpk/Y2cDKG+2N0bW+3U5PeJcuCwi8Zst2Z44iXjC9uAKXT2AgI
	2qvsK/ND6Y4g/FW9gEtWGZj1eEZupTmvRf3JMdLhRhGphybJfKugJC3FsF00FzfjGuwuvavcYNo
	rUI0nxRWSK0QNDwgGNkDGEqTbuC8u/4umu3vmnxTQ7FmFV9FSkEV4vhuRPxd/uzJa7AE8
X-Gm-Gg: AY/fxX5taaJeFkCZjcAB44Og6osebcBL9t6nLeu1ay0J2kjzHNcJ0MfMAZ7e4REIRHJ
	8U0CpmE8pA21D5t2oIowV41plbdN9wcCT8jHoUzxhxlBZXAkLrM+Y8Soj6oDd2tLtXMM3mbldAY
	pcWyBdy7FC740splONBJvGI1Bj5VMY/R+B40qqJKt1osgc32ZWlCK+4kLcsB2rbkKFv9O43yulE
	H61gHIQdp0j/FoWRcyIhZ2aM6fqlUPc7Lk08S5QfnYVOAOj4j/gJpUhPuqDPoilQlXcfIlyjAuE
	mWAAWG2gC7lE85BECbJWBkg0kvF/oIlQY6GdIdNV8ArfvHJPlXMPrneX8awGfWKmjxcvkcIsWkM
	dlcFahhAxk+nm3vFxR2iDEgi2RfGCbJcCIAVG77tmBVgK4bhVP7g8UOp5rfYWy0huTHVfTpON
X-Received: by 2002:a05:690c:6511:b0:787:f72d:2a5d with SMTP id 00721157ae682-78fb3ec5208mr65067697b3.2.1766325944091;
        Sun, 21 Dec 2025 06:05:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENen467K+vyMFnVky42xzDMgtlkejuduc7jpwaaPmkE5REAaPMsWT7W1gXzapvi894bzqQ9Q==
X-Received: by 2002:a05:690c:6511:b0:787:f72d:2a5d with SMTP id 00721157ae682-78fb3ec5208mr65067297b3.2.1766325943596;
        Sun, 21 Dec 2025 06:05:43 -0800 (PST)
Received: from [192.168.1.27] (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b90f53c16sm7312426a12.1.2025.12.21.06.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Dec 2025 06:05:41 -0800 (PST)
Message-ID: <9b363736-ac88-45bb-a428-7d3bccdc4d12@oss.qualcomm.com>
Date: Sun, 21 Dec 2025 15:05:38 +0100
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
Subject: Re: [PATCH 1/5] iio: adc: aspeed: Simplify with dev_err_probe
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar
 <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
 <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20251219-iio-dev-err-probe-v1-0-bd0fbc83c8a0@oss.qualcomm.com>
 <20251219-iio-dev-err-probe-v1-1-bd0fbc83c8a0@oss.qualcomm.com>
 <20251221120413.7f1fa877@jic23-huawei>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20251221120413.7f1fa877@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: DcNW7YcbTTaiwhG36dQyn5KGfqdxCIlV
X-Proofpoint-GUID: DcNW7YcbTTaiwhG36dQyn5KGfqdxCIlV
X-Authority-Analysis: v=2.4 cv=CeEFJbrl c=1 sm=1 tr=0 ts=6947feb9 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=8od0x7llD9z3EFROJlsA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIxMDEzMSBTYWx0ZWRfX2MPM6zDv9BnN
 RpSLpiK2udujEyQId+DL/y+I9pyMTp6SU53yLea4gyHiOu8Kz8VKiCizqzcdKpPwpc0OyQtFztd
 b53PPPEqYOqbqBJdzEIsJzxl70GC9kBof81y5cSyJhYQa3Ny0cu+B6JEfS+oHyrujQw7UBAdIcU
 Ajsq603Ec8+r74uSPdbADPsSqRrYCIUIn0xry5lMYyTxMZztCXhzQbgbm4ALdawnUf0zSp5TTgv
 FyJPnYJ4aP7m8bxgj3Dk0m1as14fYeIgC6IOvCGknfQLubv/fK2m2e8fw09UHGfw2KLH9KRwvo3
 8TPxJEyI3QQPIPyABuMvCTr1QaZetdYFCj1Jdil3+wZ3XKFV8UFqv3I++x7DwM0W2OPKeoQf+6o
 E8Vc/K8K0qg988fzL+aVxglZEaJrCdU25vzVktKgl9+ZXMu20tRU40dcsGBG93jHFu/MXyKXipp
 T53qLJ46EUCUKuAuHVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_03,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512210131

On 21/12/2025 13:04, Jonathan Cameron wrote:
> On Fri, 19 Dec 2025 15:31:50 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:
> 
>> Use dev_err_probe() to make error code handling simpler and handle
>> deferred probe nicely (avoid spamming logs).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Not a comment on this patch as such, but this would benefit from a local
> struct device *dev

Ack

Best regards,
Krzysztof

