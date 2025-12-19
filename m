Return-Path: <linux-aspeed+bounces-3163-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BA2D637B2
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:44:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFJ52b6Nz2y6G;
	Sat, 20 Dec 2025 17:44:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766154962;
	cv=none; b=Ioat6ulsyiDaxKPs//Ac28DQunau+br7jSeLj6rjiZf4b1pgc0UCJM3ENQ/RIgu4D6Vuw1ZipJEmZUdudr36hgHPvcwvvbu9H398Dig+AQfnEZoBnyykg8WMD9IfCS0my7+FbkeLyZMz63AaPbftgqnjhS56juB9hFnzZqXgb8WQFY3f7W1L5lXwyJRrmsbG6q4ZtTuq3SY4rexnm8NiomxbJaO/qBVtxCb1OCr3e5hfBLpiac7MRvrnnHv8eMiRWihfdi9RZ3Dm/RX8B6iwn7QA5U89NIAr7mrbhpqKtUdI5CSIOt8mcWhrGvngphZ9FjyBEZLl23PdkGfjcV07Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766154962; c=relaxed/relaxed;
	bh=MyMmVElDZvwdRIAby/7iW7vi4WeJE4eibZZHiU0BOnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cYq0ycK/rh34CZuQOH7OBGWGpc6VGughx3l8bjgs76NPUky+qgdCQJEkPdgb5R+cXQT5etCCjdg7Eo4JD1sU7MdI0kC8S7XRwURxIkO8wz50tSIwa+LI5e3xbk5Qv1raU427zUHUE6VBdypsLHtDKYA1GLURZXw1pGHvBSXneFiR5Byy52xjk/8RuDdiviSmeSCuZhHiIgEfMhiPQ/hyRMmr5vMs+fGgdG5FCJLUHLfR7r5Hg6PX0qm9RsDwhJXFprcBnym7/6CxDeSogOrBm7WedHPrDxvWOb0Grdl6qhjnT6BwlP0cdH+SWDHGd7FcT4Vw543Khn+UahJEAYTxHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nWMnW2pp; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TbcpiNtX; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nWMnW2pp;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TbcpiNtX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXqpT5RWCz2xfK
	for <linux-aspeed@lists.ozlabs.org>; Sat, 20 Dec 2025 01:36:01 +1100 (AEDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJBg3VM3975628
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 14:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MyMmVElDZvwdRIAby/7iW7vi4WeJE4eibZZHiU0BOnA=; b=nWMnW2ppEGj8sQO1
	72cd/O2SvycHwZ7mfK+mnsDlsERmYByJEzPltbj60Q+AIUnRJwaKAMUNtnd9sBgV
	mQnpWkAOzI5oDXDNOmhADGWtPkspwBO6OLbr3aRxqkQTbBc4KZRfKxXjRylK0JGg
	YusVtweDPoS/yOzIooZTZQELwNqQXAYnV05U1gYJyFp2jp7Nl+/57jhnjsZkqEQW
	WrCvAV6cCa5Elx5uZRFoNYwJTWu7B7dsEj9n6yKpMzeF+ZuAnI3v6VzKGsjGHBzo
	fPTjEEkH4SjwIYKQ1mGqONKLf5i3pXSk4T4mDpJsyWxGnp18xxYaDnMQ/2YqxLTx
	29VZ/g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2fjw2p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 14:35:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed6ceab125so42595661cf.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 06:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766154959; x=1766759759; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MyMmVElDZvwdRIAby/7iW7vi4WeJE4eibZZHiU0BOnA=;
        b=TbcpiNtXQ0uOxS3v9tmg36c9t0CWn3kN1yWIZo2Zyj1+moH4ezPgN0O/WbF85un0u1
         43Jhbba4MTTg3Y82QX7klBDrZx+sgQ507J5/DYa376bOM3NcEC4r39JEaCoyI1ivW+69
         K/Ce4/1BkJI/d1yZ3CVHkkL87LYV6aduhML1NEd4ofuVAskLQRGppIx62lqZK5mJgc+S
         W1uiiI8BxdWMToHWydSsSIigw4HR3DwhPn4tSOX8DmyPN8EZltmA89BLkxjjQ8NYhkNy
         qGf6QYzVJJQDnEjH6s5ofmh2W25SmVJ5Z9jcTMMTR3KNfJZtBtHVcptrwaj26C4QUnfz
         usdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766154959; x=1766759759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MyMmVElDZvwdRIAby/7iW7vi4WeJE4eibZZHiU0BOnA=;
        b=MVMpPd5CP/1LmCObjF/XiWCAveExCnVUMXNukpIv6d3UjkxLhYcDsXr0US6RBgutfh
         VijH9KIbg2SERE+yCbxWeYRVPjqVzpuYdzRVPg4GOKQ5G82LGk59bo8KgfUB7SfiwH85
         B/oL8rm1u93uJe8PVqNFY61WGaiv3ehNDuVASoBJQQn0vdJk5O/eUig6AiIQa5h7qeAU
         K1nteqFUaRSvRgAtPB1EaDNmGV6dC/xZMEKdq6mIRD55KLCRRfooO7/tOjPGFc5zVx7H
         UkEqsQzHcfWLUO64m2dwTxCyZUsupSHLsEQuM6FAKVxaR/5XlvjR/d14eLJoP0+3RbG7
         wfUg==
X-Forwarded-Encrypted: i=1; AJvYcCWySoecarEGaRS0jS4Wn/KkvjGupDn2vXWah53cYHp9HVuEDs6MCqpp+xHT5T2DVj7BkZSR9aWDs61e5X8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw+h+LfqMEbhsNGN8o30U6tCJMWMT/1BGJAbxu7hV1NXa+r/nHG
	/+2CFqcEU7oLjLhnWqPKb/N9uWj56eg0WjGVtZak0BsQcf0Hx97RkgtfQKS9wvD7niKCjj6GYj9
	P7vX7I7LbvgiyM6u1xHos5VRgfhCyaPJcmvUl9yqHQfdEoZvPSblezZBsviFIQtMV9L3E
X-Gm-Gg: AY/fxX59pMIMmBTOJ+UWYqqW3WAtD5LkO/t5SdiEQDW/OiwzygSdALxR1XmrwdNyLDm
	1qaPSjdBm+EBxtq0uYbND2H0H3uNARbWgLEIqia4ZEGWCQla8R6j+V/qRI7vS+YoceTOG2L0K3t
	4Gw1q+1P3SBqgmLniQoAZIg7e8HEj5PXj6f5zVYqCoqIx9vGJeAVvD75ocXPol710kMdBj8eVc1
	Q+Jvp0rtGe4jFxhw8h8bl4tBGmF4tlZyH7lXCChFR95Dhvs/azBpEa+T0UM6CrlI74dkfYmgs7j
	exzV5yWVSnXoCdp9dXs2X6DdVwC/ZK/BCAawotBmLWzLZH1WsIEXR7zsp5XkmW1pyir6NLbaDfw
	SpF6nx5fJhIsVXKGgrGMT6eftKap1gHaWGLgN9vO8hrGqaTdD2o1ksOpndZ0ADiCLBX/z
X-Received: by 2002:a05:622a:1e94:b0:4ee:209c:be59 with SMTP id d75a77b69052e-4f4abd9541bmr48096001cf.55.1766154958806;
        Fri, 19 Dec 2025 06:35:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFy3s+cedRD+jScDO/yti3WIT0fmJUy0yEz4L9LKCuvDsUwnGPrO9lv5lNcy508pzCE+1Jc6A==
X-Received: by 2002:a05:622a:1e94:b0:4ee:209c:be59 with SMTP id d75a77b69052e-4f4abd9541bmr48095371cf.55.1766154958397;
        Fri, 19 Dec 2025 06:35:58 -0800 (PST)
Received: from [127.0.1.1] (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ab7f86sm245145966b.17.2025.12.19.06.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 06:35:57 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 15:31:51 +0100
Subject: [PATCH 2/5] iio: adc: exynos: Simplify with dev_err_probe
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
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-iio-dev-err-probe-v1-2-bd0fbc83c8a0@oss.qualcomm.com>
References: <20251219-iio-dev-err-probe-v1-0-bd0fbc83c8a0@oss.qualcomm.com>
In-Reply-To: <20251219-iio-dev-err-probe-v1-0-bd0fbc83c8a0@oss.qualcomm.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2371;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=5iVrwaVGkX/lz9WN7/1Hu0jkjOFLzSRBWe82w60UkjU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpRWLFkLm4i1w5ivMIJ1P76TTT6SODbzjV9Amfa
 9AuVP27BKyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUVixQAKCRDBN2bmhouD
 1355D/9zK05TIVLM90YKH+VJ22rkGMMZGxQjjUGFR0oKrTlLWycdW95453AT1vgoNi5JaUt7uhG
 EEm4uMIUCWH+8hMVEji27mf/TEh4IxaMOwaO679edjyhgWMLoV93nYZ3dIEHbA3pJU/dj2JBQ3C
 mRWJowsgDCUMxCHqy9iZAHAX5nTZYZlxArvoFGlaAMrya9ou9xnNapJXa+lRHk9/Zcyx6GudSge
 M71hRmDuvoU3UX3rdLU3Y2+2KjqIt/6cWBzm09etk280kbA4IU1Om9TgwNkN9ydPmDECDHPrftn
 FZYZ/9kAVjsqrPUkaMFBAhEXW4UowvR8EbZ4b8bXf1twI5WrtlGKwpsfXXkkiUJNdDg0RPBN1Zp
 bEXk5mcZg00qSFTFxZZdNuQSYV/USnXxwVpkNZ+uAvwRkGZWoAYSLBoS6uTz/sdoDQnJSUV4OQP
 UybAN7xllOhnQwQwxlyF7rXZNAVgo/aHHU/wiDGNrcDMix34ODC7ZIu5LqbaYe2bw+0nzCpy4wp
 GLj0CDDkP88fOOZ2vI/6mCHyZpXvBMcE12Jn6EFKBOQyxG9ju0A5khAGXp8vToVjZrdMhDi/f8U
 s9v0QkdA6kJF4TjZbVqsyIEr9GKmHiq/T9Hm7HB4od4NZSU3rm+SkVpm6RFCMeUBySXr9gQJ8Pd
 ONf3bUbf6HecpuA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=NODYOk6g c=1 sm=1 tr=0 ts=694562cf cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Y7nMzdyCy53GPDWIMu8A:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: yD1Zhm5kS-cIOjCFkbfju_0vZHKtfs56
X-Proofpoint-GUID: yD1Zhm5kS-cIOjCFkbfju_0vZHKtfs56
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEyMiBTYWx0ZWRfX/4jUXT14cujk
 jFd2NDZyb6bTgvQZvVBWlvDEEgEiKY/EC4S0FmQBeMEB2vsfdHfAFi7XyG76nBrenq7sZh+f6lI
 aKsnRUEw0pmcpXWfk3VHDDJn5FdFnFtNQEhva4M65u5lpHEau3oMPbcplJWtFG8ii65MEGa0JpL
 wNiYUwwlrBqxXV6kOB/66r4GXIH+A3zvGA5tgutUU9gLKjj/KQeGMmsErqc1RK0dqjbAxL7284I
 XCYgV5HqFd4uoWCv58jpsSyV8oAh4Q7pNxmFSihdW52JGg0Q+ypOcxqfpRsD0aawblE+UvkDffy
 qdywI66JFnAFrk83wvQOpJMnBSf9dv7ndz7dZAwm+DFKCDeLgfJxFJAuuqAdOGYqCXRtE/sihSC
 3Fz+tg+T1FmfsELpMYzelNqk8vnIEFvWVAsVMj7LFS9myELW6lyEvglFr8YaSva2v9MkhW1kjO1
 2Zz8wgGEW/6aVvyhWuQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_05,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190122

Use dev_err_probe() to make error code handling simpler and handle
deferred probe nicely (avoid spamming logs).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/iio/adc/exynos_adc.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 1484adff00df..491e8dcfd91e 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -564,10 +564,8 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	info = iio_priv(indio_dev);
 
 	info->data = exynos_adc_get_data(pdev);
-	if (!info->data) {
-		dev_err(&pdev->dev, "failed getting exynos_adc_data\n");
-		return -EINVAL;
-	}
+	if (!info->data)
+		return dev_err_probe(&pdev->dev, -EINVAL, "failed getting exynos_adc_data\n");
 
 	info->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(info->regs))
@@ -578,10 +576,9 @@ static int exynos_adc_probe(struct platform_device *pdev)
 		info->pmu_map = syscon_regmap_lookup_by_phandle(
 					pdev->dev.of_node,
 					"samsung,syscon-phandle");
-		if (IS_ERR(info->pmu_map)) {
-			dev_err(&pdev->dev, "syscon regmap lookup failed.\n");
-			return PTR_ERR(info->pmu_map);
-		}
+		if (IS_ERR(info->pmu_map))
+			return dev_err_probe(&pdev->dev, PTR_ERR(info->pmu_map),
+					     "syscon regmap lookup failed.\n");
 	}
 
 	irq = platform_get_irq(pdev, 0);
@@ -593,20 +590,14 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	init_completion(&info->completion);
 
 	info->clk = devm_clk_get(&pdev->dev, "adc");
-	if (IS_ERR(info->clk)) {
-		dev_err(&pdev->dev, "failed getting clock, err = %ld\n",
-							PTR_ERR(info->clk));
-		return PTR_ERR(info->clk);
-	}
+	if (IS_ERR(info->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk), "failed getting clock\n");
 
 	if (info->data->needs_sclk) {
 		info->sclk = devm_clk_get(&pdev->dev, "sclk");
-		if (IS_ERR(info->sclk)) {
-			dev_err(&pdev->dev,
-				"failed getting sclk clock, err = %ld\n",
-				PTR_ERR(info->sclk));
-			return PTR_ERR(info->sclk);
-		}
+		if (IS_ERR(info->sclk))
+			return dev_err_probe(&pdev->dev, PTR_ERR(info->sclk),
+					     "failed getting sclk clock\n");
 	}
 
 	info->vdd = devm_regulator_get(&pdev->dev, "vdd");

-- 
2.51.0


