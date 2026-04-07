Return-Path: <linux-aspeed+bounces-3862-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5644FEDB7D0
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Apr 2026 23:21:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr2J96X2Zz2yhD;
	Wed, 08 Apr 2026 09:21:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775558662;
	cv=none; b=S6lTmcFMWvXO1XrqAew/ibFOOLN/AzoS3dby6M6Zvc1UOaKsrGPnOrAg9oP6gRoscJLO5SHj1kFPuVSzOVxa9gSyTB7/GfXHhg2l5ScYzGkDwz/RXdOJh0ieNZvU755CpeW4VE4yYmOpV9oxLS7oInLOcn7quKUvLU1uHqVVJvBqzJBWfbWk1PDo9Re6KaL9FCv1bLYiN8OfNbZIxRloQ38jEwf2mK2p6XxeMNdom7x/acvW5a5JUWnefKjd73MGg+TCaH1WvnzQPUevKndCImIgDFS+eu646I+oF7WbGit1X653iTA3oC4FavpHDuIJUT9mRw7B45WRODNkpnpATA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775558662; c=relaxed/relaxed;
	bh=MTD9t1hqbigzxlJevaxElhmdnO0mTNhhl2ZNJMUVdTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LvUUpeVsowIitt0Hbp0p14bCYx23PHdDTp+Q9GzpgUyx8A/O96Ur1laKkqRWHHOn02MdIzUqECE64MmDYIY+JDpfQ/WSxWZtVWDAxMKG384SCU4tpGVBBkEevyCTiNjJQjDLDOWd/eQ8pUZd44E7kg9UnfJ+wbfGJjFFlhJ/RQBXFIZijqz1V0QYsvD+fJa6aR8FwbI2aknyqw/ixxnFjplZ0pPm9V8npfzQC2yD6i5f7AkZWGXu7wHFnOMwZ+Z7jucY/ZoMbbs5D6WuOvId2eD1SCHFDeyAxJr4qi4mPUh/bDdbd80Hg9tiMZgY0a/K9orfnVjnQ3HUjRnboczgAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XCIgdh9o; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BNFnugHa; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XCIgdh9o;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BNFnugHa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqjVs04HMz2ySS
	for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Apr 2026 20:44:19 +1000 (AEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6376gd9n1584423
	for <linux-aspeed@lists.ozlabs.org>; Tue, 7 Apr 2026 10:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MTD9t1hqbigzxlJevaxElhmdnO0mTNhhl2ZNJMUVdTo=; b=XCIgdh9oFtxN7f1n
	I19F2JvWqML+rxALbWWVYKa5IiAGMYBIRxNKNITPkOKUFHYJT/tPe4xU/qUQoLHm
	VWdKipioX4MB1spbfXtkuVRQC0yGU+dg96sUn1ECEZs3oSZFiGptER4Ir6pPTIYp
	IXrUjkNHCcWczP0XP5FKbRlDqp8xx7gz9NWg8ZtHyjUeYry+COV6tIbb5F8Uv7IF
	qOvEBZcLeqtMCahQBwYkmjU/HdQSppCsrGz83VMxjH7zsje10Yhh1iAzPUXcHi89
	c1fT+xoY1SOB17kLHT68COGckrU9wmheSILI33772cCeW3wPlHoRrStM2MwSmhkR
	BquH0A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr9tb88-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Apr 2026 10:44:16 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b4076dc16so216052281cf.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Apr 2026 03:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775558656; x=1776163456; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTD9t1hqbigzxlJevaxElhmdnO0mTNhhl2ZNJMUVdTo=;
        b=BNFnugHa9hmbnV45P/2mIjyXRH079Iup4ZzigMC0RtHeR9szXWEdvdUTzPhAJv8gbc
         OYCSuKu7ANkvCndApfUlcqgScfiNSXMAqK1TbQrCUWlPweOtUb/jvnkrRFqcK62/VDOt
         dCARCowAhwX95lmJEFc0LZnZpjBkN4EnpfoDYd8KbIVbhz23+UscrndVbp0aSFMfbCHc
         ZUaxduicrZMNRE05ft00sr/riQcrcK5kN6+uaSRPhftZgRItRwH0YwDZ75va0iFCEqco
         Doil/NucAuo3A5CZYm9FS9VBJxCop4h6lhMouDua9xFLQg+pi1O3Bkt0GSE6Vroeisaw
         Z2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775558656; x=1776163456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MTD9t1hqbigzxlJevaxElhmdnO0mTNhhl2ZNJMUVdTo=;
        b=F8Ov+PrPtk++D5NmxDSznVe3eoIO4xoowrlJJ7wHRe+JNrZkCGniImXBgq3Doycub4
         UWTogsBXEdh1YyJOzldnQTufz8sN/YgR7QcUQNgDQ4URzQ/6QxG9e44UsXfM6NCSlr9C
         RRQcEoSXo7nKJvTyDZBzga88wYDcpTCXh1nQQ52/xezliNMhgbK7DUziUDfdOlins1rG
         Mo9AoTxFU/D472vlvfpGAdLBigPs0qmsJcOTS5K9PfYNeXZ8z1ig123mtfj4vQmhzW6M
         u/Ebld8B8mh5KZ0gmMXzOQZpi6ylkxD9gpwE3DbJg7muqgMCAMtOCm/oJRkcjX6vpQxQ
         t4zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKuCHvXtkXcQVrLYahKpxHo6kJlsU+XKAyyEBQajMonM2kiuKqpRtqHYRgIPpjlf3iGWHnaF7/xWIvthk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx9F8t8bdWcQVJ2STg6in1cBsKCPpBv2N07aTxHQ+VQzcKnsEIP
	y4jxxeSAZUBwzog+FWozw1dovqf7WVxXGqqovH30h1QJdtwUC/kFZmECUGx339YCiqaWebIfjGs
	CXoO40HS4ybJZdxxeyCBbntHdh3SjejgB2UlU+6KWnVpao72M74SyxaezoEkzvEYYQiyD
X-Gm-Gg: AeBDiev6AGR2VsiOqSV8VFz4Qsa6B8kACeU4+9zrKtTqk9N8shSW/8jqRBDMEDaLaLR
	vS0IB+RLXmJidN4RI1bIA2mTbk5FygiTBLw1RkCTq5cy7AzjocEES6gqboxvSTviVQrwYF9Zan4
	al3bgeKSzqiSNsBxcIOiVALEX71ruCDzMtHblOcZGl3Xxgn4QIKnb4GUYeOYNJjmUK/OIDymyCI
	vPGxJ2FIA+UlzQRxqwSIMi+fhRCKV2yF1hYoncVfgW8jMtK/HQfX04P7R1mvUG+GvmetllGOMlG
	7170cuYC9xkWMlIQB37YaQ0vjqpH9kjjthiQuBhmyXh0Sg/Xl7gTkN12EDuIKGJW9RrG+BfxWkz
	RKijWC1pHRfKyMSzDTGLyAfyomadFhfZdrL1RPNqQkVmZpMNq/A==
X-Received: by 2002:a05:622a:1103:b0:509:1045:efd0 with SMTP id d75a77b69052e-50d62a82b33mr246737591cf.33.1775558655693;
        Tue, 07 Apr 2026 03:44:15 -0700 (PDT)
X-Received: by 2002:a05:622a:1103:b0:509:1045:efd0 with SMTP id d75a77b69052e-50d62a82b33mr246737201cf.33.1775558655192;
        Tue, 07 Apr 2026 03:44:15 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:b36f:5370:5f91:2d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488bfc31418sm64902885e9.3.2026.04.07.03.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 03:44:14 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: linusw@kernel.org, brgl@kernel.org, joel@jms.id.au,
        andrew@codeconstruct.com.au, Chen Jung Ku <ku.loong@gapp.nthu.edu.tw>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: aspeed: fix unsigned long int declaration
Date: Tue,  7 Apr 2026 12:44:05 +0200
Message-ID: <177555863870.54615.7184296575672654167.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260405144803.31358-1-ku.loong@gapp.nthu.edu.tw>
References: <20260405144803.31358-1-ku.loong@gapp.nthu.edu.tw>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SMdykuvH c=1 sm=1 tr=0 ts=69d4e000 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=W_L-z-rN-aJSQ1DoVdMA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA5OSBTYWx0ZWRfX8JKh/DaNpC4i
 muB1vit5TD3BqIxuaoQ/saW5841TSr8fqm75S8jVnX6o0JqXoP94RLbqUZoCVxVpch/DwFNZQsT
 LL8Ml3cXUhL1mbagAb07qnkIFJdFH1LUtSXkATB6AO7ltVEh+MsKFJFMuwutWUZZ0We5SUhWmpu
 JP6ahiv9gvfUwUKR0RngZgBddfQyXCKQzr40eNmjbt8x5cp3OMuhuA07yrQTR1pi1zxoG4xPBbd
 TjcJ+bCaccZUFu8hcl2P51psPywaJ04GrVB7wYVFURatYmu6w2+E47MJAxtXXiGFRn8wHWdgZKo
 QPOtGEUuDxpZ7OFUiJ5akIOWr2IqyMml/iAaAgv4k2X0JVaWMLr7kuZfe1AYeXlmlTGs+izTDlg
 miF8LfPo9Y/UqUGQe/x97WzpiwDwHPOSgPau3lwkkGLcyf0H67C5bXwwRJG59E8LnHyqUX13UoW
 SC0I5/u7XY8s2uFYucA==
X-Proofpoint-GUID: zrJVUt8uE-BhLR3_4kBVdDWvBwbcaOcA
X-Proofpoint-ORIG-GUID: zrJVUt8uE-BhLR3_4kBVdDWvBwbcaOcA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070099


On Sun, 05 Apr 2026 22:48:03 +0800, Chen Jung Ku wrote:
> Replace "unsigned long int" with "unsigned long"
> to follow Linux kernel coding style.
> No functional change intended.
> 
> 

Applied, thanks!

[1/1] gpio: aspeed: fix unsigned long int declaration
      https://git.kernel.org/brgl/c/50f1c48b155b74528b0b251b8c4e097fddd5ab46

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

