Return-Path: <linux-aspeed+bounces-4590-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67622C53200
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Jul 2026 23:37:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9TJS5CWJz2yjp;
	Thu, 30 Jul 2026 09:37:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785305827;
	cv=none; b=cxrf6wVHryO4IdeSirSzPWFScOUjVqweobj7SCqR3jt2GtV07x3gYJimjqgxx4yt4sgpcl0bMj7PbGS0C5DCGrVzlA26Tgi7zpyX/P1yDpK/ZGoiGCqcarRrLLlIlh6OYfmpbdV/qoKCY7498iom/nmG/26Bw+1exDbjx20+V5Kb0PvnKJKwIZ+TDMq+zQSjmHL/IyAss+4nBOaZbfx8E8aaz2AgCruagWmmfy7n9LqRYQL/ZPbdsWKQdN3V4nivdQA15096j806CUFLg2y1coPKnTGhTwi08v/3RJyCf8hx+4K5JRx3p5jnObPYW2zPZxs9GFmI2NNgfa8+h3drpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785305827; c=relaxed/relaxed;
	bh=Tz7KhVWynfK4YJouO55SMawbYSSOZKSjjVpnD5FwaYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlwiDyym30P4ONGI/CRPRgf6bYfBkR6bBlhj765AdE0ZgC0iFXADJeUROXlm0KgGE4ztcnYS6F+Qse7PP5I1yF2pz9Q6CH/QyjA1gR0LsHZKcIhtOqgMljNhTCvoI5aSI6/hyF/0mDadmsI9SZD0k0oy+b5cCrAloTnSCLueMOycbYE8g4VJezDWLRw3FuIwDd94uaAoL8TKao0r3yIOgtzeCFeQ1At4cWKAIq7r8MaWVtkbXRjfhMuwSAxPxLBRxUIrc8NO/aA2/j92P+8OF+yNt1fHJIyF/z5xzg8GJaTRI4QaoEw1klOTwVfpPX7Z9laAxem8PNmRK7B6q1CZ/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YtCQKYJK; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gfHIttZa; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YtCQKYJK;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gfHIttZa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h92DH0CwMz2yDr
	for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jul 2026 16:17:01 +1000 (AEST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T4cK7u897801
	for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jul 2026 06:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Tz7KhVWynfK4YJouO55SMawbYSSOZKSjjVpnD5FwaYQ=; b=YtCQKYJKWcBf0EDD
	oUBMOY2zBQW95QjDHeLJW4TgIst97oo7Iggs2DLRkeXxpsQk25CkeMojtOagDCad
	8KbSu/5o3VUqvHNepbTc2f+tmv3qtIPAwVMrSBVSSNYZgei2mJeY8k5nJIN1+AYp
	c3t/ZwX9B2s9PkDK8WyzWQ1o0pZzFP/g/vNFFflKWlcU+8e15L7xdNh6PH5rSKew
	BdVx31bBDJl8rN4VcKK4cI9jDz2MF1ztSvHNY6MBiVw7id5uFqaHz2+aMrYLBFZy
	feceyXl1+3anshl/u/leQeBbqsvwTlRvONo35T64KNf0e6ctXXrdz+vw9rUVMooz
	GSjV3g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqa330dqc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jul 2026 06:16:57 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8f1e4e0eac1so7618316d6.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 28 Jul 2026 23:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785305817; x=1785910617; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tz7KhVWynfK4YJouO55SMawbYSSOZKSjjVpnD5FwaYQ=;
        b=gfHIttZadLp5OLG9rUl5Pw1UxioueUQxm8ynXkWfgMa5SrQmwPRRbekucxmNnkHVPS
         Gbhg46BHd1WQNkGwmqY2wG2PwrVAexa1fH84/UOmxkiUcyGICxuMEF7CT3hXqcj79sjD
         Rvn8LBRdUjTNL/klT36EWOLdksuan2QreGs9XXlBSrrAifzFcjWQJS/ZXlzBt8kif0K/
         mTI0r8onToLitjU+Or7EG7WRH3JAo/SN81pGMCDv9EVKcKwjOhuk4AYXCTtvszRTt3tm
         6rTjrLMDZbPVc4XOUCsoLZWSuPEENHYXPaCcDGGjI3+R9PXsCno90k0Al6Zn8U/xHtF6
         GZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785305817; x=1785910617;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tz7KhVWynfK4YJouO55SMawbYSSOZKSjjVpnD5FwaYQ=;
        b=krNs8fTwJ402TXV/1ddPcQwRpKrJyARGEt19gvp+I9y1jcP2W9uA58Fas7D2wcCt3b
         OQg0YvCXiZMLKWI+SMM+VyzGrAL5UH2bfkUEU7iulqDL6zdI4YfcoVbx8zjWLYg9g13E
         bhifuLfFpKXo6ttmojXBHMQM7UmJ732LxFUBcobiWarHtJLlZYjyiLePIwa/AxYHYVN2
         rFv0I6GUX2O+Na1GFA5ZibeoK5/OYSuPWGBxfLv3kiQE9rGStXvy804TbbRq6kW5mO/E
         9SCexko4+tGeayZ9IH87/jYVSKoaXefISl4VnXYPmQX2GwjjFxWM7fx0Z6QBbT3WNr8u
         304g==
X-Forwarded-Encrypted: i=1; AHgh+RoUz5mNxHoDYJQQucxyTD5k5pn97wwkPtyQ1mXGrb5Gj/Bc4g76P6w9NFqHHY0UcWO2qG+WJl2iDSVSLec=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzjiTRV5kDtwyyEq8r98frmhDY/O9epRHhKjJktaNo+NSnZc6iM
	B1Y+6ggEfX/5WSyl9MLaf9ehKmdQAWNFAsLTafUqL96tAyvMt0kJJOeJYAaNuh5W5d49iNbreYq
	++za2a+mbyHW2ZHQLWK84Uir6z70ykDCY62fSOnIkQ6CShwdM4tiPxIv+bhP0beW/erdm
X-Gm-Gg: AR+sD11KfQyi7HQcLN9gEQcxZ5aXxJOvmS1ShdcUKdf5lktk4FOh63cu0AKXfYlDn89
	blJ0UL+ABaZVhgi/N/kWcCPVLl1vmx/S1wItRsqjohQnehJq6nxknXf9aMRhgXjmOd/yvBfatjn
	1ssMdk/zQX+1G35vImBaXRVTi4NZX4xsFvoPLe0nO0+UvjbzeR2gRLj5ZS2UzdCgZQV7WygOpTV
	2+ElKDoah4vA/JafZ01WyRpkPW5A/CqliyavT6pXRVAanQ+OghM0xPPj5LJAdhHhfew+9B5GIix
	kTsHhMAzl04iRuebOf6dirQWsiYgU39JlcxwJyQoN3Q9qMplh8Em1MpvyCZ7jxywpQYpPqhbhP8
	xz12KLDtdXNEfP3bu0jif1rBdQCb7KQ==
X-Received: by 2002:ac8:5915:0:b0:517:87bc:9b47 with SMTP id d75a77b69052e-529d713e451mr47632991cf.39.1785305816414;
        Tue, 28 Jul 2026 23:16:56 -0700 (PDT)
X-Received: by 2002:ac8:5915:0:b0:517:87bc:9b47 with SMTP id d75a77b69052e-529d713e451mr47632701cf.39.1785305815597;
        Tue, 28 Jul 2026 23:16:55 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6aa3940sm5367800f8f.7.2026.07.28.23.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 23:16:54 -0700 (PDT)
Message-ID: <d8927b08-f743-4b1c-85ad-f64b9e5b326f@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 08:16:52 +0200
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
Subject: Re: [PATCH v4 2/2] ARM: dts: aspeed: Add NVIDIA VR-NVL BMC
To: Jacky Huang <jackyhuang@nvidia.com>
Cc: andrew@codeconstruct.com.au, joel@jms.id.au,
        Rob Herring
 <robh@kernel.org>, conor+dt@kernel.org, andrew@lunn.ch,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
References: <20260728085640.1001890-1-jackyhuang@nvidia.com>
 <20260728085640.1001890-3-jackyhuang@nvidia.com>
 <20260728143952.GA2121505-robh@kernel.org>
 <20260729060612.1085870-1-jackyhuang@nvidia.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260729060612.1085870-1-jackyhuang@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA0OSBTYWx0ZWRfX5E1GOlJGcNSb
 i9RwY9oIte+5jVKqlov+HXwpzN3oIOZEZMRIA8gZOMsR6BdLW3YIAZnaw78O7KHQN9d8kZ2jUku
 +n2o/tJxEkWqNIH6B/ULdWI4mYeNpTT1+pPlTugIh2lOac1mogz1P3kL+kNvWI8oA7E6L04oH1y
 Z2I2jPsuwVeXl+zjkZvqeOK73cf8F/D58UORqF43TF073hg/Gub27ljyMjP84XWrjziXUw3KwGd
 3DI9J21FQYWJHL7BSv0j2Cf5OvxIlYesGHTyvyAVri0QIO5otRE35qHlyGFQJAzyLRKm1E9l+Qg
 fzQYqmfhBSpImlP4Ho3Ja3Iw0KdEs3tLZfLKu9nDe5BzlDPpq037avHiMR1Q2R4zljyhGvw0qng
 dn2jFXPhNJV7BA3j5rPWFDjQpfe7D9jxlbTbuByomhBnZz+hiU3Rp7niD8Tgh3UsrueIpEfLyAR
 o5EmDq7saOHAZyWp6pw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA0OSBTYWx0ZWRfXyAtHAnW6IKms
 tu1nv2x7kFvSoWx9Hfm4cBs4sRzp6Y7MEYoJh91OrlZl/I1ega9LXIdpqBZnu775M7QUx+/1qtA
 yGHRUXG4safuKYmb6Cz0uBCsR53LCCM=
X-Proofpoint-ORIG-GUID: 0qp_3BU7XfBM-MQIF5XJXcPiDkguronD
X-Authority-Analysis: v=2.4 cv=Ap/eGu9P c=1 sm=1 tr=0 ts=6a699ad9 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=LSH1fm4cC_m-g0oQB94A:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: 0qp_3BU7XfBM-MQIF5XJXcPiDkguronD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_02,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290049

On 29/07/2026 08:06, Jacky Huang wrote:
> Hi Rob,
> 
> Thank you very much for the review.
> 
> On Tue, Jul 28, 2026 at 09:39:52AM -0500, Rob Herring wrote:
>>> +				cp2112g: device@2 {
>>
>> This and other devices should have a compatible string and associated
>> schema. The hub probably should too.
> 
> Will fix in v5.
> 
>>> +	flash@0 {
>>
>> Needs a compatible.
> 
> The flash@0 node augments the corresponding node defined in
> aspeed-g6.dtsi, which already carries compatible = "jedec,spi-nor",
> so the compatible is inherited. The same applies to the flash@0
> under &spi2.
> 
>>> +		status = "okay";
>>
>> okay is the default, so not needed.
> 
> The flash@0 node in aspeed-g6.dtsi is status = "disabled", so the
> board file needs status = "okay" to enable it.
> 

Why are you extending existing nodes that way instead of phandle/label?
You write confusing code, so that's why you have such comments.

Best regards,
Krzysztof

