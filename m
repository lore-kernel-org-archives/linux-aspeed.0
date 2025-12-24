Return-Path: <linux-aspeed+bounces-3216-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096A2E784BE
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Dec 2025 01:41:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dff8Q5xT0z2yFg;
	Mon, 29 Dec 2025 12:41:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766580288;
	cv=none; b=bp2oNtjwaXI00Kqi1zee4y+lETMqmKLCUw+ehHpLsOjOWLme5ZU0gyR4XKaxcCe2/bG8CUg8D4f1Tl8G25vePYF8zHaa2NdPehhObe5VZMT7ly3uixNnoh/VxV8rdC/ys7qrcZWCK9DJkLcoDqimMsfP4BF6n6jrJnRpPImrY8eiOjKyrV35+2ZpaK5andblQlhXnBOeMKyK4VwW1ZXdvXZqVYBMqAS9NfVi97qItv9Bo17bK14Q6ZGNW33GLu8GV5fOQDKKz3eo0r3DZCV3VWP5diY+NgiGr9x9MkZEihZgzMGlW1NsfSTSMvvKaSDc+bL4COeai/P+oI8NKc1SOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766580288; c=relaxed/relaxed;
	bh=Q42Wt6YQQMyV5WzJ6PsXaJWt4ok5u3HGH6HCtPPT8tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqOzJzheb0L+ayVZZqhFHfAQBSYNmjpNg1qMX2D3GoQxyFdPNqIE2povQHMgK9Nh/ybaEK+EUqz+PPAqArRuBTvNr/oKURabUeTbFXFguiYHwtr+lccl3IwJn08IVu5uFwZofEe49etl4acWe5kG0wsFRUjmocmHdTpR04a8Z1QTNmJPUlFK2bogMTXjTZu20tktab2I82NYgM7EyE/1I1oprsGONty8xTz7G+cBkqAG4nq3fTN34sjRiWRKIE2mli6rrglBUQoMgDctq2IozvMFO300/erbjOPXfBJW9WZ7deAS8qStF37V5y6zQRFgIodRxQ1z4E7/qsrIWQGdIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EyG039ql; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J92ZsUUA; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EyG039ql;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J92ZsUUA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbs5r0QvNz2yPM
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 23:44:47 +1100 (AEDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BO6oZc8682292
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 12:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Q42Wt6YQQMy
	V5WzJ6PsXaJWt4ok5u3HGH6HCtPPT8tI=; b=EyG039qluJLQrwOHYmf1TPfuYqJ
	EUv7Si2+J+Yn4uUZQAHmtkD2Rg90l0SeNMEz7XgDKh4ZAvhfjTvU6b40xhh9vqya
	QYhhgscCfAFpUCr9EdDFV1TbT9Oy9DALM839ltVE0aOmedJGJxfCfuESXwvCIf/v
	IX2Q2vjQlSkiFafQ+8THJPo6azKMMB1TBtzM22/I1bP1r9J4btfzErn2cuRYDcqo
	tejMeOlQkNLjqgOTx1J6AGwl8GpWyoiKnhdoYtSj/NpOWP/DCffI+IcrS6e0pYfu
	CZkTeai7dCau3/EpMmdrrzO9YvxPQ8mQ+ThyMmbeK5CJqbGYLttAosUY+Yw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7yvq2mat-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 12:44:44 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f1d26abbd8so160832151cf.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 04:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766580284; x=1767185084; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q42Wt6YQQMyV5WzJ6PsXaJWt4ok5u3HGH6HCtPPT8tI=;
        b=J92ZsUUAHwnbNDMI0/52jgGXL7g9n8vc3qQZ1oanAyPmfyMM77Qp2vWSmwHVOQG7/o
         0iNUwdot3h44kMlE47dG5rrQnhppYOUzTjavvxDanTIV8YMqsU7Og6tY6Mg4AFYk/MuL
         zh2tmHG6mSiYbMGH/ctXm35zx/fa461cJI2p+/k0oq5Kq3I7Nq2Vp/+W1NyS5W5IN6wk
         fRJFBXiNj4gVeuGRfkuN5EBOQnmKt9NADRQPLsIzkueQHbSsjnYDPiSDpDunnDg8tItp
         kHAdwWnqRKKa75uTPzWDDGcL65CxgqfmX8rvlGldGQcDU+mOOd+0v54aDIeGlce2vr5C
         krMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766580284; x=1767185084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q42Wt6YQQMyV5WzJ6PsXaJWt4ok5u3HGH6HCtPPT8tI=;
        b=HMSEsnvXEE7I4MvAxIe/sNNydKpJS9yVWi14JVOCCAmQ3gqrhCrEm5FJHUamzE2l4s
         PjgigmyWP2CB9QSF/F/yDmMUpCtC1aq4/B7dApsEA07yiLkFF30PXG0wpLf1BukbSjh4
         bzeV224NTsmQn94D5UYxlhspkDdnrHpBaC4UG7aa3BKZYuAVR0P3cpwY0kGMBv2j72tF
         i21bM7jNnPBz8w/yWjBl6bIherob6LXTGlXY0Nl/InSZmUsFptq+w/LhbdvSh3HPKnbV
         168L4dOjJdv1CxgIMG4STzMdCRq1tKmB3JAUa+1Ev16yM6BH1A/1zEaK9Q8HXRDSfVbt
         izRA==
X-Forwarded-Encrypted: i=1; AJvYcCWL5OZA55W985lS1zIU083RlSoMZP+c04UqugfAuVHp1UuW0QEgHbz2QzL6rDxbbC9pNW6f7IGk6KCCQD0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyuIevhK9bPfuGDbujFRcP3xXWNP42UN0e9PGKo9nGX8FH3SEj+
	jC7SuzvuLlTUe9xZfJIq1XA1qE6F6rOlqnNan/q6KDOgd1XBMhNpVTzmof9xLnF3ob7TqgwM+xb
	9Nx6WUMS0mXOFGs7TSlS7leQoAtdYTmn/1ExRF86s/uhSArfAKpfQKjnVg5oNzG29lUJA
X-Gm-Gg: AY/fxX5riQyy1owpWt0TcsdQpyCmYMQRjGt7gtKEhie8wuaEsqxPf7TdgLvd3Hh+/CB
	trMPImhr1pVd/lAI+gHSYlNHONw84jdvJ689h26nuiHfaGHZYZakr7nnnCK4SyNWMFGH6gPusvQ
	i0Ufg4pVuvWC1MuqjZAURFDaRg2pW3kAeD5Qajzt2kGHByFJERAMyxMSWaPS7JiEx+9nFjp9pAQ
	KTF6E90UWpGIcawqdgrxnEhnKzEQfpFILquUOKMJ3ZAbtz9/fdjqrMJLxsWzQyKkOTi6Wq2Wqag
	4rDQ1d+j1ibE4b4bMPckZth3Ng903sFW1YwBxNsNHb5dgUzWN9rXiVynySmNsKGsN06/RCCnBwQ
	wtNqnHKElp1BsryyyDwEgAsgQV49tgeW/GDiRt8Huo4a2hJOB9nGrs9gopAJyyPiA/uFZdw==
X-Received: by 2002:a05:622a:5c91:b0:4ed:dcf0:6c42 with SMTP id d75a77b69052e-4f4abd8cb47mr285724371cf.40.1766580284060;
        Wed, 24 Dec 2025 04:44:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6SEHMYDYA8cOoMdGU+wI1nJZyyHIVwBwMN0zDb8qXgGwcSCAA2ns9/RvpbF4+vcO82fQYuQ==
X-Received: by 2002:a05:622a:5c91:b0:4ed:dcf0:6c42 with SMTP id d75a77b69052e-4f4abd8cb47mr285724031cf.40.1766580283705;
        Wed, 24 Dec 2025 04:44:43 -0800 (PST)
Received: from quoll.home (83.5.187.232.ipv4.supernova.orange.pl. [83.5.187.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9159a6d0sm16832679a12.28.2025.12.24.04.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 04:44:43 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Aubin Constans <aubin.constans@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Robert Richter <rric@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Adrian Hunter <adrian.hunter@intel.com>, Joel Stanley <joel@jms.id.au>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, llvm@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 3/4] mmc: jz4740: Fix Wvoid-pointer-to-enum-cast warning
Date: Wed, 24 Dec 2025 13:44:34 +0100
Message-ID: <20251224124431.208434-7-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224124431.208434-5-krzysztof.kozlowski@oss.qualcomm.com>
References: <20251224124431.208434-5-krzysztof.kozlowski@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=951; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=2mcyqiagsyS6KbHVm6G4XsCoUJ2/y8VeNfievVmr+/E=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpS+AwLY++OPJe0PmtQ519o76/sm2PjQUF16HOk
 5iqYI9gB/eJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUvgMAAKCRDBN2bmhouD
 18i4D/4yKnoNGj9XpY+uqY/3QBwS5rDae2aCSD3dEpBSWOOULCNZiFsS1J55iA/S2FXDgqAr9F3
 ckKd+btf1+IFsLDViCAYXw7uLQeSeOmvLWK+ra9wtVw2Zp43jK6FRIZwfGtO581/yi4ugP9snz8
 pahyOm9mxmpCnrc6Io+WxpDN4w2Fiy45MrdkXDXaex95uwShbSPrGHyO6y3yOHPi/wyk5kD5B/m
 uW9j/KUatAOWoi6nXS1k0d9uKc7URL89nuGuuh84WLnfzBcgFdGp58RIffvya28RIdhu37sObjJ
 Ec2BSI8YxhhuaceTY9AbfQxMvMQx0lrZNdSSVcwSsiAa+UO0oC28mimD0wMs3FcQkyzWDA7X9Pe
 5ErZ4zczTBfA6iU6r68IIbYDBpEcB2bUZvcRBOgUh41ZYEGcoRDzCO1WPLXE7FHuvxocAqQoW4u
 f4hywtji9qeLHRe6+KCIshDCJjRsD8OinSUPQrb1wJgWlllBXd5HZE1oFknBrzKTq3nlE/ycH9q
 UWat9qr2fi5qeXsRKA3ofMyxButI9zWvOlY8Qa2U3WRnHewg84VcGpJVDjQf8i5kVHnruSHANVY
 wtpCrR+aH0q64B5p1JLWwY+ErdIISyVeUe76i7y2aNq7e2xGc1amo3YgbMBT7QCe8aO4SoHKjoo taDYynggtM6k2dw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 08Vk-HQHNh-hNbXbmxQXaQxSt8XwMglJ
X-Authority-Analysis: v=2.4 cv=abZsXBot c=1 sm=1 tr=0 ts=694be03d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=urQ9wjG1USoGuMoDBEOPbA==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=hUqV6_F3YIy6dExb4dYA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 08Vk-HQHNh-hNbXbmxQXaQxSt8XwMglJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDExMCBTYWx0ZWRfX8OxH/R4njPWy
 tsVDBjgWATgz8mWYEDnSTYi+rv9hEy47hepSuz+SIpo0m2XzoW2YAjacTP+lGTe7s3ByS72KqH0
 adu+488nJXw3OXyUC2UQFyPzXGYEuJfutlwHtqMdRKsjD134zsZEvPQ8w+S0PGGDsNgeCXXdsjN
 zhcApi4ii6VTl5MvhVKTTZ+B4MOsyksYXoPda8QKz8/TNCycLKloUtJnlaF6irmKc+GVUuHWlKm
 JynISGJBRlFPx83zluYr29RZKN9WLCB6f0nVeOAJXtcheorWEKEBuRLOkeZjPkV6WTzj8geWvdx
 B7ieyVPmq12helMKA2f13TjpXMeiR3RIBUd0LAEqdbHZu8bAa7Wt8b3HRHgbAq43rWOf8N3dduO
 nGPYmDRqkXKvoRz3GfR421FMF/kdQDGuEmHm676yxhQ6n2P+5HGxopy0Yzdq4aHxCrTOdK4b/lg
 r5z9uhU4NdpZ+RwHX/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512240110

"jz4740" is an enum, thus cast of pointer on 64-bit compile test with
clang W=1 causes:

  jz4740_mmc.c:1055:18: error: cast to smaller integer type 'enum jz4740_mmc_version' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/mmc/host/jz4740_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 6a0d0250d47b..6a3c26b7c82d 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1052,7 +1052,7 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	host = mmc_priv(mmc);
 
 	/* Default if no match is JZ4740 */
-	host->version = (enum jz4740_mmc_version)device_get_match_data(&pdev->dev);
+	host->version = (unsigned long)device_get_match_data(&pdev->dev);
 
 	ret = mmc_of_parse(mmc);
 	if (ret)
-- 
2.51.0


