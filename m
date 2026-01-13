Return-Path: <linux-aspeed+bounces-3305-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2899BD29DEC
	for <linux-aspeed@archiver.kernel.org>; Tue, 13 Jan 2026 09:29:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dr3qQ3nVRz2xWJ;
	Tue, 13 Jan 2026 20:29:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768288704;
	cv=none; b=Ge3cjBOrrPTIMbG6F3hzVCJcx2OiViDpdGwNT5h4UDwck6wSjMWoJtDZKFYMy9umH9pVLm9jMe1ibQojommpqusG8XV7hR/a05fdQgH/dmn7PPp51vqnGJnJr6ZPmEGeMWpHTipTt+RdKQ6mP7T0bQ9EAMEv73BYGfRu8mtrxVWCHGlmzgyC/eViKmKQnyU+GLr2+KlS4aYBIKgtNrkTGQ57faGXwq+JMhDrUGM6mL+oqUoS5A6djA0d0MVxSs61w8+WlPsSF3bK7p7Mo4XNgg0Or0PFv4vu/Y65AtyWeg9BnBjt/UJsS292oKwldku2tlXIlN46rrUq6BDh1hXsgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768288704; c=relaxed/relaxed;
	bh=Mz1uyotn+Lo27VQ/BNtnflO/fKdr21z5CeR8OsS9Fwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/3w7LusFUgZvZobEJJ8dSJaFfoPga/6ked1qhGfzBRBoUUDfD/voCp2lDICaCkMpJgvASDZjn4TZ2qDNwth7A/CvR3gdAAXP0uNgNJpHlq9lEiq30uae4cHs6s8Vcvwxb6L2P9HkDYczhknO6Wx0tf5PTVery1Go5LgM7s2onF9rGgbjvst6MSkvlcvyzHb0CzVWJS4iFO7Nj6cgZubgDenVYkiOpDbf6ldON+Bxz/76dYD9hZ4+9sgqOKLuFNE8D9D+JGRexKCzeIzeJ+sQZCe3168vwOYvoDQZQmlivH93bbjdK0k7BMiPDd4W9cUR+BGcLB20cM4wfNGxUy4nA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IogpQjmH; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HGEXCzCA; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IogpQjmH;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HGEXCzCA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dr0w01PHyz2xHP
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 Jan 2026 18:18:23 +1100 (AEDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D6pauP2604851
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 Jan 2026 07:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mz1uyotn+Lo27VQ/BNtnflO/fKdr21z5CeR8OsS9Fwc=; b=IogpQjmHSofRI68V
	SkrJvw4LmqajQU5MNAcxqKi2FT70owGdklMTFsvxJKpOAJSvZYwTdAcqd48+a+jP
	rjI5NDaykzkeDE1nVa3txkJXoKsJKzzXeoRXzKSjLVhuVbmKaB1HS6lics+n5BvP
	1y/gKvV6NpV9qrXnMiaXXE+V1Xy4TFmFpWBfz2IfEzPt3aNJJGGykciR6Kib7ibO
	w1am60ztduMcKHW1tD/X/JJCeL47XhmGdeyw2K5ZD8Pv/WoyOwZ4zrPOnjynGzuA
	AkAbbRRJqZ5SOAHNLfnt2nway45WXm+U3ISHOSdFQWh9wWqSZ4GoJZ0fBPx6mh4B
	ADaAdw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn7uysnqb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 Jan 2026 07:18:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8bb0ae16a63so830259385a.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 12 Jan 2026 23:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768288701; x=1768893501; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Mz1uyotn+Lo27VQ/BNtnflO/fKdr21z5CeR8OsS9Fwc=;
        b=HGEXCzCA5yW5eLNV3wVN9BU+necgg3mabAVB5vnKXiEDB933ZcfvFIePbVw2qMPIfe
         2qLVMt0sMbYlZhjUyWkqIpXSA4VBpnkdROI3ECLDZvtRPNZ4vQdCviejKbAjU2g2p8Nw
         DzV7yOXSNVZFLz+akoKeB7c+RMJFn7EQaJW8mdy/dBEvFTxX4cRky42Xn4aCc+ry28bX
         iIGLY+a5TQhA1qd+Rnup4MLlA6jOTSbZPGFMRoCSogborDBqcC5ZDEao5brxPfoLK4nG
         JskQExIW/uYpKC1wJFagrM0jUS8QF/cLhqzApk0FyvgJ8k/3Lg9v0EA4D2/7jt0SAeq1
         wRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768288701; x=1768893501;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mz1uyotn+Lo27VQ/BNtnflO/fKdr21z5CeR8OsS9Fwc=;
        b=UvUuXxQfWxH/u0++p+2+hesi/Lal1Icavs+AGHhH5q/d7rokkmQs2BId4OIeBftyzJ
         NQ/HWSSZSOPeyDefPhSGvoE8cOfpSsmT/gNfvjdFSaXpTwDo3mmTX5laBs/3pO2xFe++
         7Qam3RlJ84lg9oPh4Y9ebptfu/VVtluSQnCMNcNOp15fF5RqxMqGdAmFqBm0Xz4YQXfq
         idl7nTBGt6VSPIIWAArnUom4hGsCVZtye3i7KSNW3QNGOe50ySje/A+/lMHaLLzjLYl4
         nZRuT5n2uxHd9edfsAHeSprIiwy2UHcIXFkqhuBp4mQ49QPsZlNsF9j9MRyRmpoj7hi0
         cdHg==
X-Forwarded-Encrypted: i=1; AJvYcCXHPtLKvHSj+ziMc4oaRLzfYvtyg5oGHGMtQLd3d0nW5Qgm1/LRWrNfOw5j2i4yVx4iBpdZt3LagJe0DvA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzVebZapNGxUzijAWlIwYFhv8OXr7SrMh6iIYFcMZX6pqc8ml4+
	+QO87tJOCBFFozearFjT5D8UoUbb64e0qhgGvpadlmCHm1jldJxOjhCq38hDWbnr9UbLH5wPujc
	cs8km2s4tfAAt1TrjEdi7KZ7hfy9FY2O2XcXugLQWmxsE8bFfiiesLeBNQN9GH3Rb5jo8
X-Gm-Gg: AY/fxX5EBbvxfOucl3cHF71LiJwJVJGEorrm0XZgo6BlY0E13CO6qi6RKyrT9MgSbnn
	/ZOdK5zMXo45RfrOR6yQEi/+jB8d+Y2+dSNYbLcbscMPUd/AHAcJjDwNg8AJSoDr5KxOs53FM3p
	J8Ow/PX+MA0RwfuSYvSrlPOo1RnSj6pERxpR6B/nZHP/c4OYqc4rSg9ASLz68ESYI50S70WJLyr
	xcb0ab4iFuskJ+JVtKIxa8JTmx4X6nd5+lyWemwOfKtY8ISl3Fd6P2BCQsp7pH1jKcrLm5amEo/
	hTHiIW19wuvL0aPEVtDC/FjtRDI27C+Sf0D9LifvGGaApN1vi2DLjGexdN5PL08YBwOL5OPcDh0
	HF5GuV/GcrKZSJsaG2JkceOKw597RCq4WvXExuA==
X-Received: by 2002:a05:620a:40c2:b0:8b2:d56a:f301 with SMTP id af79cd13be357-8c389356249mr2855358285a.14.1768288701075;
        Mon, 12 Jan 2026 23:18:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFv3ItqozzK8RLD/MQVHmBVCdLU5MZEpggQld1MU1FwUv0Pdz1KQmnU+9nc8GL923HLQEJG2w==
X-Received: by 2002:a05:620a:40c2:b0:8b2:d56a:f301 with SMTP id af79cd13be357-8c389356249mr2855355985a.14.1768288700635;
        Mon, 12 Jan 2026 23:18:20 -0800 (PST)
Received: from [192.168.1.29] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65d5dd40sm5388155e87.60.2026.01.12.23.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 23:18:20 -0800 (PST)
Message-ID: <17f46ae0-f89f-4a33-8a4b-a97dfb32b8a6@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 08:18:18 +0100
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
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: aspeed: add Meta ventura2 board
To: Kyle Hsieh <kylehsieh1995@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260113-ventura2_initial_dts-v3-0-2dbfda6a5b47@gmail.com>
 <20260113-ventura2_initial_dts-v3-1-2dbfda6a5b47@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20260113-ventura2_initial_dts-v3-1-2dbfda6a5b47@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JIdTt7_RzwiHlM47IgjX16mVZWbGIx1Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA1OSBTYWx0ZWRfX2QQ08DOc/LMF
 j/gM0Ec0FeIcobHw5YOyhQUVI7W0AnWxeTDNKJu8BosDStJ72qr9mQ9/EvrrbUuhX8eNrJ5Uj7R
 /VgyM8deh3nC9wGQl7JVRZwXbzS2/kCpLDrmJ2ZzHe8tNx49SSScXuPRSuqWhfy18/KmE7mBlPv
 +597lxKT7LlkcAT/o4Ykl1q0qiNRp2IG4mfp/0n2S/+yeBaMPb4jREkTnByAhEaXf3+m9rDspYx
 wGnegTWyMJ34UlkScXhr9VPaAveb07oMCe2YtM79D22SExws4HmPW+OP3a8RZpI5mdykeKmxEWu
 JRevKFKZ7jdxuYhUH84tu2Hg8lzQGVDiE5TZuhEpo0MaGGLEjQWSLnqVh6owzXlrcL62EkW7b1Z
 pHVtQP9P1szkLovmxeGjxujw+3BqZfFev5reKdVz/Vx5MEguc1E9RfDHm3KUPshKof5zWMEFtMx
 OARMf/vJDD+aah7PBnQ==
X-Authority-Analysis: v=2.4 cv=bpdBxUai c=1 sm=1 tr=0 ts=6965f1be cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=0ndkzm5UIWKU6r-Gs7EA:9
 a=QEXdDO2ut3YA:10 a=xCCTlrCo5GEA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: JIdTt7_RzwiHlM47IgjX16mVZWbGIx1Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130059

On 13/01/2026 03:57, Kyle Hsieh wrote:
> Document the new compatibles used on Facebook ventura2.
> 
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> ---

Read carefully last message from v2. I am not going to respond more to this.

Best regards,
Krzysztof

