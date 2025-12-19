Return-Path: <linux-aspeed+bounces-3157-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A2BE6689E
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:44:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFHQ0Hgyz2yFQ;
	Sat, 20 Dec 2025 17:44:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766156315;
	cv=none; b=krihZ49WDrpucwaVhuXj9QtbckiSG75pfr8lE0HkUdlMXW0rnA+fYobytKdlvd+ypAD78DogCl872pllLxkfUmcwZ0Wku8KzgQ9CuCKlZibk75Y2Z8vDn+o0ZogvbgpDWw0zz07x/zKQ2X3Kne5wXjUXWAuRMBC8UIXQKA0tvjbzk4F9tDsa312ZGBLA66hB0+++Kbw3+yc1DQnPddPy1Kcj+iFHRZ5L00Zv5Vo+yVKgtt2ypw2qKyLKG5xX6hbjiWf1qOYWwLFl+EojOX3zdftgWO522TWm+jSP3KYsbaogFc/PruLenMZGS3HWVZgXXhwTX8UFzPzxxMHd5xCgUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766156315; c=relaxed/relaxed;
	bh=2llrig2VlkvP/lmBhRWbS2Hi5oOu1YmedcLpczcjcPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jx8FXtmuw1UtI35s1TNTAsTVO5hNRo9eaiC0mpdeRdHlQ3jq6ApaNaaGoeFoZ/JE9aj3sv6y6B8kwZNzLC0UtBRmmwpOlGyx9xeqNtuv1uT2ST8Zvih+odVqLU6Ms7CY4f4uol8TzouGkXl42vwQFiXKCbNFvwuE0ZPM0Dao32ytPdGDsqvTfoLE4P7F1v7/xVb0PomUuo4heZqaqXPI46Z0DCkyOBb/USYCu/rIlzoxbkbuKH+5TmxSb3h0MLUTfwoldZ/z0gVAgPNOyUCghDPPxGvUHkkM7IrVBjK85zghOFdowdkWP4/JiAyOQU6oVfkKcqIFps5tlcGW5WSqgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=flCd99Wd; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YcHHCJKk; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=konrad.dybcio@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=flCd99Wd;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YcHHCJKk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=konrad.dybcio@oss.qualcomm.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 679 seconds by postgrey-1.37 at boromir; Sat, 20 Dec 2025 01:58:34 AEDT
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXrJV51JKz2xfK
	for <linux-aspeed@lists.ozlabs.org>; Sat, 20 Dec 2025 01:58:34 +1100 (AEDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJBZOPU3559261
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 14:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2llrig2VlkvP/lmBhRWbS2Hi5oOu1YmedcLpczcjcPg=; b=flCd99WdIB49zGTc
	An1q1Hdk9XGhbN7baTxHWBodnU9IW1OuTO4Ri0dNVIe8iKl7+QAxfGOpvzuCuLEy
	xutFuVjEyrqw13VgdUvVFv/TcsBADcZ40zRSGu56JCSh58KPtaX2B8Zqa5wSJ3dT
	4QNz3wM7Ej+VVrSQg244rwJ0Vw048cNys4KRXIQjG6w5u1PeVzz6WSn8qLflojB1
	JlEIWc3hcVgEKy2lZwJ6hWJouHkUytIFY5KwMWr+GVd1+YiAaXWBg3lHj/+Ak8Zq
	+mBm1TjcUcEm0SnXRB7dSKGsjp+mO3B4MpXuM+moWgwrG0kO++3MO2VScncdD5Jh
	1Fgk+Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2cb15x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 14:47:12 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b1be0fdfe1so68203285a.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 06:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766155631; x=1766760431; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2llrig2VlkvP/lmBhRWbS2Hi5oOu1YmedcLpczcjcPg=;
        b=YcHHCJKk1LeZJnwQDobTTsYUbLXYct0NSDMLLIMdNBUcAH7WshJ2LBI5bO/3W1Jc8m
         60k+nzN2fylgA5A5p4DTHnqtWQxSIu+HG+dvBU8VI3xistNFO0OLbEoYNHMWAs2XjLTr
         47W7QlSRRWbSrHDEszz+pNEqBVDDPVQTE2DqXjCcFgCdoVIdYGhNt9hWRpaWD3kj0/4x
         V4+ImwBsYfAK37Q8SLjm9S+m6vg8APqtGRrp6lcPK6Zmqaov/IPILelaRThmCc/iTIuP
         M9UgDt9wBGkZ/zbImTzM8kkw4r6LqXpWiIfu4aD7VTvqegpZjdG+J0/poKvvbszsoUFi
         fSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766155631; x=1766760431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2llrig2VlkvP/lmBhRWbS2Hi5oOu1YmedcLpczcjcPg=;
        b=YX4axOAEcpL2QGJ4wEhXnSfnScGaG89hyL0oAI41jBOGSn+YY1f1XuNklFu8dNa2OZ
         0mhtG3/RZpYF16ukvRL9J9oq57G8b7R16w+wDh0rjiZ3pXQ5cp0l4K8VA8cHDoaFL/Zx
         /5BsbUm5e8ghdHq6wVx0chrlwTrG0xixnsSJ2G1SlIsSp+mlEB/AGYzEBqizUNzClZoY
         IuaEcQLOmc7AZk8NnHupZvo6XJ4grbmnoyCPiUlrjwoHeloYEdnQhvxZUpri95m8TAyu
         DcmreQGXnXSx4j7TKzlr43x/AWo73s1rRbpCEXm2BCUFXmvp/IemjiwY9OsTQRxE2J0w
         LQQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYWPMkOYaxYGFkCiK4yVYkllg2i0/wGhxiyN0ImCeK8EGmPMHlAgw2Cztjdsua0FttB1YQGysBPoL0v68=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YymzwfHS9AvI165eIasqsMb+AfXaF4E/gbAt9IXLOWlnIP9WSNu
	0ExL5FZXpoIL4ItGFpp0j6dHpQxMNm5XPsLZSs0jKT1CMsh391Lp8TZ0fbyP1DDJQKLhkYTTxfq
	n87FhujwTyKlL4ffP+YZ1lk5q830zvv/lFKgurUb0GvJi9zEeBUTZuY3Z8DW4cNc/OlKK
X-Gm-Gg: AY/fxX5N87KPVV8H403txKYqgQs0GEwSoek9MPR0FfRmTBa64VQP1vrZtsVY9W5qbP+
	wSUxm2WTzAfpXbi3seoJcC3sZWEXXjscYIMgfgKZ6kR6dr5AQnUyN1jA0RE1EiwV5Tu22qwIBQk
	x9PbLTnb+qwKNYGroDn79e8rtfnMSXNmWqMUdQdHiSo0+xkPUqCQhc3pMgtbt9ZbusiSa9zyy0e
	QedW+snI035VXMVuNJcMye8XMXKusAhoBHXFQ2iEOPi8hUBGsQrZJ1NiELBEfX4PeqdWkNkleix
	/uW+WDTYlKzDBdPXQr3PdlrYg3iHDlrxdoFHG66v4wnCvWJVltxQW1H1a2mXJ6WIEzDoKmT1oAZ
	hczvnX6i1DJkC8h+ZV++GzXksWuSM8rfm2bNvvxXLke4pm66MYs9YMr6CMGJXVvAeXg==
X-Received: by 2002:a05:620a:2911:b0:8a2:568c:a88b with SMTP id af79cd13be357-8c08fbbc3damr339357985a.11.1766155631585;
        Fri, 19 Dec 2025 06:47:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEve108+vsMnz6uQvHSLsQBNpRTIRrSI8CXrS6ViEziIGCv/1+cO2DfuCTVgDsGgQRx9jhOg==
X-Received: by 2002:a05:620a:2911:b0:8a2:568c:a88b with SMTP id af79cd13be357-8c08fbbc3damr339351385a.11.1766155630854;
        Fri, 19 Dec 2025 06:47:10 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9105b31esm2309173a12.13.2025.12.19.06.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 06:47:10 -0800 (PST)
Message-ID: <528cf0f7-6025-45de-a061-2d4f6fcc5bce@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 15:47:07 +0100
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
Subject: Re: [PATCH 3/5] iio: adc: qcom-spmi-rradc: Simplify with
 dev_err_probe
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar
 <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
 <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20251219-iio-dev-err-probe-v1-0-bd0fbc83c8a0@oss.qualcomm.com>
 <20251219-iio-dev-err-probe-v1-3-bd0fbc83c8a0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251219-iio-dev-err-probe-v1-3-bd0fbc83c8a0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cpSWUl4i c=1 sm=1 tr=0 ts=69456570 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Y9TzTQZwL3x8CsvTrzoA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEyNCBTYWx0ZWRfX+WNDjFUH6/jx
 R7vgalLw6KB5ySdmbWFXbomw4hHLLLHYH2T2ki64KA5GoAORqkNqD9zVsah6i5H+crkR+acPHJS
 B0MHWc/c9A1ZGgPd6zAwuG2amlrSo8ke3XnFKaOeaRFFRp/IqX9IooHHKBQWfswioieOHdmABU4
 1Af7M43hweAM53PbmkgiOwO60INqbr2C663WO99Wnj7Zt/r6ZqoAXW8dEXtEvhM+p9Bnffh7Vzp
 im1Wfg8p5eL9CUj/xl9kodfB6+y4LxkPx6H2aLD6Er4ofouK5heZv3quAnnymvOK6dfJ4Co3a6/
 uD28gABIsJUpco9vzwoLGmTrlD/Bjdbm4rqzna/V+vO2tgvWWwHnTG9uIG23iyhRW7A/gDUyHsr
 JPzcd0EkOIYhgnZ6j+zUQ6HEeTOJUOlxYcddk1Xy/dI5fY4BsdFOpD8GMfntqKbuqbTLvaOifPQ
 YuQVgFOng2+Rvsd4AuQ==
X-Proofpoint-GUID: pRiD7HGYmQ1MIPojFNnNnej6-JDCfTQU
X-Proofpoint-ORIG-GUID: pRiD7HGYmQ1MIPojFNnNnej6-JDCfTQU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_05,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190124

On 12/19/25 3:31 PM, Krzysztof Kozlowski wrote:
> Use dev_err_probe() to make error code handling simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

