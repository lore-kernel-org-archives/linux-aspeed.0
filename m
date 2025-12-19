Return-Path: <linux-aspeed+bounces-3167-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE30E668B3
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:45:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFJb6KXPz2yFW;
	Sat, 20 Dec 2025 17:45:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766146406;
	cv=none; b=nppaEJCNPHAOz1ja5k7wCPdoq/dTQ8OGTO2pVZYa34C6Cebhv127bXBNAP8uPwF2DA0q4oowxvLeweLXO7/UqjKUUUF+xRxaa7Qhrh9MqVuj8LYw8Yg/PVOLYmfyuH3NsGIu3Wi7pvc2wh54z8VJaEKM1y3lXZiv+9QsW7ko0Gs2b9JPskXE363ZWhZDHx2NJWVsHk8g5KSdYCNaezbVQJA6LIK9dxlabvH6vl/0A4lRb0rrCc6sNt5rJA+DNwEPokSw/UZ5/VKHt/y+yyAIXf3adxkt1xmnTVqAs6VZOLUKLnpmOnoyiDI7iz+6ga527DfKgraDJmtyNTy8UgCFxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766146406; c=relaxed/relaxed;
	bh=N1SiMSN4YFI47fVa4EmdLS4EUY7t39OCz7eP3piX5/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LjGIoY8ae7+aLJqequGR++2OFKeL5NNnrrfKdb5/dUW+HZkEu0HNr5XccfnQsq+XaabhIwl+Yz1LUEpGfOxdFKLm/Vp6lGg895bQmdjREPn1VXhgBMtHRR9LXgoEFAWffxQVcxCWcUbwEoYLSuGSApE46IDwIH1oOlB6t6/cj3NNRA8HUyiQYPbLwmoEJydunQHaGFaTD/ei8KnbPzDZWJwsnRha5hNHE8WhPfWr5TxB/RxYsYiPagp0GLpalqXsdGsmCMXMUp8I+az6T5T9PDFR2SjbWwwuX9mxUISfiz4Sh+lNNH2mp2f57b97teaL9PWoIPET9lxCEwFo2tjWzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oAoU70eQ; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K+gUPrYX; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oAoU70eQ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K+gUPrYX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXmdy0tBRz2yFY
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 23:13:25 +1100 (AEDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJBXZ8n3700755
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 12:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N1SiMSN4YFI47fVa4EmdLS4EUY7t39OCz7eP3piX5/4=; b=oAoU70eQ+UKsqRJm
	9h4Me6M810ZDhXVcAmgP6QH2v72cm2idRcRE3KBX0EdGiZvxFU3AqbIKkovX35mn
	/DCRS0tx4VqC04kxXHy2BggVAK94/CdnppUmvlXI+27BUxRcenP6OFLBzfswqRW2
	0HZmBfCJWab3sazQHINHY+OMXQn8BI5WFhcVgoTIj33XFAWjretSRO/XU/obAo5P
	k4xGS6YjwoP0kq3a8BrP4pp0wackkmHJEvbICILodiJ3BXjKkPezW3jjvSU8Y8rr
	eXyCkuZJU2bReVBq5Zq/5C31J8PPYl5FcNAbAb/A393tULWPvtTeETw3SVdlZfat
	Xyfwwg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2ejh4d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 12:13:23 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed69f9ce96so51788921cf.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 04:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766146403; x=1766751203; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1SiMSN4YFI47fVa4EmdLS4EUY7t39OCz7eP3piX5/4=;
        b=K+gUPrYXgPyVRMPIvpErSy8ECAq+BACJm3nwOdV0TCAXK1ZiG11TabqzSifRu0xSqq
         niFJ68RLL397OkIKN4uFa2WAWCESWRESe6raYLu3aflTNdT707K6YZy/cPkBvKCPvb9H
         WTKiKlfbbg+Dq7dAiWn/CRzCPX17rCPXt/jfhvRIoBpmDMiLZCQoPiUnaB3d/lKoubNY
         dGdpEfwBuBUUUHeoLkyV1vo/j2a4eXQZ+49qT2vHWPLYGNshSnSguB5I1nRGrtl6ncMx
         91xh05HHK0b9oyeY9iAFvvwHbnUYQ8mFPItzWMwO+nSwfi+p86f8yxRlo8kACOravHrU
         ESZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766146403; x=1766751203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N1SiMSN4YFI47fVa4EmdLS4EUY7t39OCz7eP3piX5/4=;
        b=DCvbdvBJPnj0J5lY99RkYnuggQf3YEr2wgXX2iThotjtHa6sJ2b5XKUC24V5micAsv
         tDxr2u1hWdinbciryeYgwyrfT4yKkqm0agCXd3WhUFKFaKa/pN1/BAOaqrzvhJNLQ+63
         ph8yNOMTJu03MOIh0krRtJp8a+80KHGlSDvdJw5xYKRVIEpiZE7O8TVmwdJUniqteC7u
         c9pifAfdIFEQJ3TceHjExkBeLcoI84Yf2BeD11hU+ZeDNgXTVVaqbhF1kZr863k6js5w
         PsF3uZsYcl6sJIfES1q2hBa/H//A/P221Y0/QypNLL9kXtnVcDg50exX/3LEjGSGrHN2
         9Dtw==
X-Forwarded-Encrypted: i=1; AJvYcCUxTgAMQbjRvOG/Omkt4I4OvU/Y2f+JhQEf/0F4ft6FTJtKvqpBo9+ELVfsTrK9uNCYtcER44MJgOjyG08=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwyLt+Z/jG9wd3ZyKMFvyKlWDbvH2oAmiPWom8/jzU2giOordwv
	+8NYMA7mEhKCblyJ2BzsGF+I1sX57Esz++Ezq2YlW2LWpqc7HkH/jAouj75NO+MteYwZq7jqBxY
	k9Vp3vHLQQezeg7R6Xc2DSBfre9fYwAQHA5/7dcWybV25hMnQC3iJRjoyL5vuZUWzrkDV
X-Gm-Gg: AY/fxX7kbtO0+p2aWM9u68s3RvUXjogYSy3kewvGFhUS5vkV/4yX2z0RYXtKkFt6VF2
	CAjMIU7xeRfW/i6gOhpsub/kUeVMsT8mjHWVbEGfa6mjjnn8c5KznsYnLug7HBjkcax+s3DilFG
	JO+4TgSpVGYXG+IHMJg0GN8e51pmd6ADzDCD62MYZjmBlEok2QClN/OOHcBOp9+4emqPDiG9a8v
	rMs+fOJBtsIi+wepBD65FyhnDssPkKVRNeGFcmVHqNqx9JIcQ/96sQD6QNCzeorvej8mgTgQmxW
	+iZzzAqK5D/5kiNuzzftmBfXtlrETQ4gvwkpAqeNuYsSVKvT2LZU3uQgUjv3stx4KiTSlqw3q5b
	ZgaDa0aP7wuAtXQPewcYkY+9IsMRUVhhp0+FVx5p/Vlk85AY7NsnqXKsIs219epcN/c3T
X-Received: by 2002:a05:622a:40c4:b0:4ed:aa7b:e1b6 with SMTP id d75a77b69052e-4f4abcb8c61mr39213271cf.12.1766146403252;
        Fri, 19 Dec 2025 04:13:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYPcW3PfPMaYa5ah0lfNmydmhG1OoCxBqy4V58pqAmy3pqVEKIRr0KG4hKAWOlE4QVSR+jVQ==
X-Received: by 2002:a05:622a:40c4:b0:4ed:aa7b:e1b6 with SMTP id d75a77b69052e-4f4abcb8c61mr39212871cf.12.1766146402846;
        Fri, 19 Dec 2025 04:13:22 -0800 (PST)
Received: from [127.0.1.1] (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f48606sm220309466b.62.2025.12.19.04.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 04:13:22 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 13:13:13 +0100
Subject: [PATCH v3 2/3] gpio: creg-snps: Simplify with
 device_get_match_data()
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
Message-Id: <20251219-gpio-of-match-v3-2-6b84194a02a8@oss.qualcomm.com>
References: <20251219-gpio-of-match-v3-0-6b84194a02a8@oss.qualcomm.com>
In-Reply-To: <20251219-gpio-of-match-v3-0-6b84194a02a8@oss.qualcomm.com>
To: Linus Walleij <linus.walleij@linaro.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=kQh9fxqgF0kkLwllXs7yncT1rqd2kM3SqX3A0JVP670=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpRUFcitFmh96JIq34IbMP3prMi1Qv439mdn6P6
 pO/55cXvQ+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUVBXAAKCRDBN2bmhouD
 16G3D/9MR2b44uM01ef1M+Bm/4qifQ4xOiNZUWkSJhnzHwxwPTJcZk015ecjjs0wHCt/CVuc6fg
 JMbTbHa3QqUzrOxOFOgNDndX2Cwbm/0TxMsRSejmUrLApdeywMx22tOEjr619KzQvR84+pquTHb
 dA4LnsD3ft3RVOIWUs9ozIeg2/Hyd8EcBFTPkqave/fazJSiiqGaAdRyyiufvd4U/Ook0amT4o8
 NWWUEH4FYl2OrH+3xdxNBCHJowcAP5T4kD1CsqjR1YXdnQH8Nh29uC+RpLbi8eQoLSklzhEw0fS
 vgo4OPfMu0legugoBTtIbMj3xfZ5D5xFb+YHQJdg0flH9gxnDOUdqFNewEJMypm9Eu97ZVBojsC
 tErUii6TnOqWBtpN4jFlMLA5ogxVaU+Kxfl3BLd6TN2O67TDyQp+hsAhPpttaAqjU7X/h//20LE
 jddOb0qoMc1a9X/EBlwF3InjSKaRYORz753RXJpyhwiKvXabTXOAPoYW3eD2XKlFip7kaDKE7ds
 FFoGZk5pJasjNXEE3hTphHI4F/yhooWkgFrliK6XzUpkLa5LgtHd9tPqZGOkywqpfPTX+qR0W4z
 2bRo8r1oCorUGiJLFexpdADlS3Nag8ER+7RWolfxUsgdrO+Xaxh4Uv7uAqc2IZVui4hLNHOeHGI
 uyl0hgYwVIMYcbg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: 7J-WB101Va6owkMIoKgemfmc3dZ8NHt8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEwMSBTYWx0ZWRfX6tl/XXEPxMt8
 kQH7j9zzcE/YHWgXQxRLkQgpFAeM+eu0EMXnJ+qzZemeM7D2S+e+pk46dR/w78CgS8LWpNd5h0M
 dpLNdgQVQUe8YMaBzIOh7GeavdHWM3le5BF3KVFd3IEd0uOThrtheNCtRuaU/RYMvD632u0WRs9
 +vOJ8yxrYg/5nEbtmnI1PQX7U+ib2l3Na11yxjlrm0HSt4FnyvWmu3bHEYkZzaYSiIoKkATDrNi
 s1q0jKbMY1j9WauCm0cF1Xdq1/Z9ghcyoQYZ0fR01Pz1V+KIYJhtcx8oLVQSQ90+H5iwmzE37tB
 g5BrtQu3HF6IeGUcYzVBRa3T5h7GRSe5yXm3pHbljOBXYN7k6e7H5J74NO2VggsrObJqopihdEs
 dhiRBftLodjkQHjfOvjVeiakzqUnAZatB4+BKNyDABSlFlWkbkYkeAw1rJRHuK6EYNVToasqVH3
 D+Rg3ZD0Jbn6mjKJr1A==
X-Proofpoint-ORIG-GUID: 7J-WB101Va6owkMIoKgemfmc3dZ8NHt8
X-Authority-Analysis: v=2.4 cv=EabFgfmC c=1 sm=1 tr=0 ts=69454163 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=lsN0KVCTPuDBfKR-m84A:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190101

Driver's probe function matches against driver's of_device_id table,
where each entry has non-NULL match data, so of_match_node() can be
simplified with device_get_match_data().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpio/gpio-creg-snps.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-creg-snps.c b/drivers/gpio/gpio-creg-snps.c
index f8ea961fa1de..157ab90f5ba8 100644
--- a/drivers/gpio/gpio-creg-snps.c
+++ b/drivers/gpio/gpio-creg-snps.c
@@ -134,7 +134,6 @@ static const struct of_device_id creg_gpio_ids[] = {
 
 static int creg_gpio_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	struct creg_gpio *hcg;
 	u32 ngpios;
@@ -148,8 +147,7 @@ static int creg_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(hcg->regs))
 		return PTR_ERR(hcg->regs);
 
-	match = of_match_node(creg_gpio_ids, pdev->dev.of_node);
-	hcg->layout = match->data;
+	hcg->layout = device_get_match_data(dev);
 	if (!hcg->layout)
 		return -EINVAL;
 

-- 
2.51.0


