Return-Path: <linux-aspeed+bounces-4415-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98558C43602
	for <linux-aspeed@archiver.kernel.org>; Mon,  6 Jul 2026 23:47:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvLcR0B6Tz2yVv;
	Tue, 07 Jul 2026 09:47:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783360778;
	cv=none; b=gm0XVhdLyG2Rc8Abic6nihIDpBPN7rN0EYXgJvo2jvPfmZqY7Cn8Xo8elmSfsAHrpk9uoKKwC2ZtDetlRsSve3w6tC7YVe8ixC6jqshOnW8dQoiFsJAXt/mAN+11X6iN1Ilj7WzQha+G5pDqoFoab7VT70NN415+GTy0iOBJshnKVwEv9uIKcPFUvr1DpAcIL7RPo9J3hSA8CAKuxsa1OycoBc05BCK1r6sxRmC4aeJMB7PBMDIwnLLftINDNDYqoSWQy9Y39ODB84eFL1HM/s1XpY9DlH21HYPoiN8t/X+BN0w+8Umk7b8i+p5QRcayAOlg2xzk1z8hr2zwP2++bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783360778; c=relaxed/relaxed;
	bh=Iq2547hWkLyPSn5vKecOMarotbQZRKymJ/MEe/TR2/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h8K/PYXwib3kCjAdko7YGahxH0MKfuUTWGNPXhKMpTktEqTOmc/iUMAD8zCXpZoyRVRIctGVqdFJfSQu4NXsvmECEQj7GMVY7Nn6GRRCKWnmd3C78n8D3AuUYT/KzGbiUBAHl9V7+NQKwdG2FFhYMWOcFF/00W/wTWoro0TQ7lEgZrAtVrs+K0WSrj1AhZacNWd+i1znLl6bybaleUI+LWQ6k6StX7X3RZmBI0c7flwHZJOfJJKcMiWBflp5jnC5+1+M3gCfLG+8RyHAWBreFBaM/TxJWkm+hYjkKZVmA7iGXek036ec6wfXavBSBU400Rn23PT8gOhRqtbt/o3Vmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D9dS6Ztg; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bwMMboRe; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D9dS6Ztg;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bwMMboRe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvBvX3Lgmz3bps
	for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Jul 2026 03:59:33 +1000 (AEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF392981458
	for <linux-aspeed@lists.ozlabs.org>; Mon, 6 Jul 2026 17:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Iq2547hWkLyPSn5vKecOMarotbQZRKymJ/MEe/TR2/0=; b=D9dS6ZtggisbxqVw
	VXNH20ZxC6/PiGXHw90REEh6dwZDMS/8Jps1l/TWXPucoikMfgj6/7kXVq/NKlNl
	vJS6Q0k+mxlZuBPzq9yJYF3aNmV/jEWJTFacqRhoMZWDgMY567uc3dRVdSsfe0X9
	zW2U7ywrsTYVhbudEW1+hSMxaMQ3ynWaUvrj29AwT6OdeXJx39z984puadx2X8LL
	uROqcqcMF2JbosjruZSiUG/4pYiTo3vkztm09jTeaeQsjHUR06VnXyhoEkdXVfkf
	O/eI2ovfqvxDE019fdtnxBb6v8DHB40rJ8lpwmcD3rJbRtBa2qrKvEtsd3K7ycM9
	j9S81Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgtcq4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Mon, 06 Jul 2026 17:59:31 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e63df032bso9057785a.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 06 Jul 2026 10:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783360770; x=1783965570; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Iq2547hWkLyPSn5vKecOMarotbQZRKymJ/MEe/TR2/0=;
        b=bwMMboReYRpA0RA0Uz0QT0MfnyApkzPn1axQ407CTeFKABpQweti07sLsIkZDyZAnj
         DKqX9PxpWcfCfZFAEvexBAOs6J3JFIHeZ9rqvbRMhT6yccDiODGiwsoiNmoXn8SDApP6
         9IDHWJoIRox4a5iMaEkjoESH2yWmiMZdeO5WvDHliERtoVaCyheStYMbKeUR2lVSeyq9
         FGJse+uyLxLL1PiLddqOV+Xv7YNS9NuG+5y05bVxDZ/4mgzmy9yZ2iShscPEZTBXelGX
         mC5pZ97DLY5LGRnfZVP+TlK1M772+tpqSi6+Dnsp24cE+SYVABrgyj7f0oRJhxSJJpLl
         7pSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783360770; x=1783965570;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iq2547hWkLyPSn5vKecOMarotbQZRKymJ/MEe/TR2/0=;
        b=bEwTJY33R5BuM1HydEtSbzr3cd24Qqj05rHFHIHQRb8j8kliOXx2YUUQ+GcpJcjyoL
         NpXnLnLZIWfewhC+OoeUCNiDNiA5G1UmF4rywpgC4Dxa4aYoiE0aCefU3T4HVJHGp1aY
         URRw3gkpBkV8rZ08BY6V5MSAQ7ZXOFTFeET0uAbOWlHs54UliYK7/0CXlvsSrygsFzo5
         qdS7Xa+G4LjbqZXyr+cZrBS/w2bR96m9QAshSm5Mm1Ua6q9w3cEFU6+OE6OTmYIqbVAO
         n/OQAGPtsdWlqy+R2/kyD2j0D8Pv/DtBsn2iRHQAF+iheiuWaeZu5Ke7+zwttpHX2POH
         z+Ig==
X-Forwarded-Encrypted: i=1; AHgh+Rq2jgd5XqjxSDbt5+NJ6iXXtqrIuyw5mA0HSEn4U6myij7t3zKa5pV7E6M1YvL3DSYVop1mbUQrna0amfc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx8Ph0GAehG/qgXyqnWVovi+6dT3XlLFoYjKgJRMu4SmQKzibGP
	1z4ypXnvKqD+D7AOea+HLh81ndb2mnnPcGrd13CYRMhzwexo9BibRJrXSMybpLeZ37MgKJxKEOs
	yFgAK0Zy7XKVOOsJox9V93W3FCNenuAqxQTh6DBbfhGX99BUKlp/ZAhECk+5ele5IFDxg
X-Gm-Gg: AfdE7cnMAzYDpSWb4sTTGcvJjrhr/3XcljAKnvXF/T57gu03tbaYGpqj7n9d3+vcdaE
	ZGF1ZM6j++XQ8Dr9lkkExMXel3MBkCAhvYKo4XGQrpODoB3Ea4fkBVvCYJm/Q+gbDNRrgdY8009
	kkya7qxgNAe4LLLKpx2qi+G3QYGDI1LWlhQSkuxdR5j7flQ/IYpGMDVOdaqHnyjT89l7BbRBrJ+
	3UF6qbxRGEXH9Ate8O4jj0XiV55CyYOAmcmUpIME2hJ/ObQD82NDdtR81yL5H1Imp0xnD6FKJdn
	xSoINrOOomGqaKgRWYcMtV9hwsYDDyvLJENVcMO/wcJVatflDYzqKB1R0KLBH43YnH8BIzH9qgI
	0xXET/YKpOe0LgTsNynOs9VjFCWwu7cP+D8045VI9
X-Received: by 2002:a05:620a:3944:b0:929:7356:2e51 with SMTP id af79cd13be357-92e8b29ea49mr2099261985a.11.1783360770238;
        Mon, 06 Jul 2026 10:59:30 -0700 (PDT)
X-Received: by 2002:a05:620a:3944:b0:929:7356:2e51 with SMTP id af79cd13be357-92e8b29ea49mr2099257485a.11.1783360769800;
        Mon, 06 Jul 2026 10:59:29 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e01c00c0sm727595e9.5.2026.07.06.10.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 10:59:29 -0700 (PDT)
Message-ID: <0c6ddedf-df46-48a3-8810-8ac36c06d507@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 19:59:27 +0200
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
Subject: Re: [PATCH] ARM: dts: aspeed: Correct indentation
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260706101930.341635-2-krzysztof.kozlowski@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260706101930.341635-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kUKcFFLAovQoGdJJlBprMt3IrfBMcDI_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE4MSBTYWx0ZWRfX69Yl2QFr3iGK
 KZa21RWWrkx/UNOHkCCr0ZmOi9NtYYXdlRjyFqsN+EFcYbCoZLFfoF0DaZwTUxVXmbenWbFzIwG
 HhrsRutqIdOhflAfmizZNQ9CmRV3SKCfOSMPG8h9LbvSSHfdfju5XfR3yTe7f70LksBuEKvRM6S
 cQwbHRWAYIdNAeHbCOHCIGKgVXhHkgdWu+c4N0X6bheZxM6P29LLe6CBVaOmZH+uAH7ElOHA0P6
 zJTs4tAgsc1VfVTG1haSqIOGg+GJivb3Cg6X5ZvLjE45ymqBQQMjJy8uxVs64dTmi2YM6g4VK06
 YzvWlc90NSrNOhUW1mMdGTCcOl1AKG6CT+SqAHPVUK86/v8T+ZrAn2I5ktPLTusdqdjGfu73EOs
 /GsaKjXMvD0aXrWec6GdqRG1UJQieyMN/nh+kV0NOcQtWDjaCpN41M4O7INimFZSpb3MaQb2TLo
 lQdvUvhcQIBH7a1hMGQ==
X-Proofpoint-ORIG-GUID: kUKcFFLAovQoGdJJlBprMt3IrfBMcDI_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE4MSBTYWx0ZWRfX+vCGpvu2cX6f
 YZKCY7co3hdVh0ZNjeWj28J019Ceo+kluf8DIRYYgJvJryeMJyp1WvcjhV/mmMBq22iBSKUWC0B
 joYsm0tJ8RYdB5u2hLYH5C+guKsQgnA=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4bed03 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=LetsCp1wghxSMK_TJDwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060181

On 06/07/2026 12:19, Krzysztof Kozlowski wrote:
> Correct spaces or mix of tabs+spaces into proper tab-indented lines.
> No functional impact (same DTB).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> Ongoing bigger work for all bindings and DTS with built-in checker (dt-check-style).
> ---


I will have v2.

Best regards,
Krzysztof

