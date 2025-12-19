Return-Path: <linux-aspeed+bounces-3165-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0B1E668AF
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:45:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFJZ64Lmz2yFY;
	Sat, 20 Dec 2025 17:45:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766146406;
	cv=none; b=GU2BRQHR40gyjNhuMPof8IZBX/HvIHoQZFDIrVY23qtKckmN8zDWzRAfQyb6By4D71xxpb5ajjnmuEnObiEqCciMZtIdd8pFhTFVGp4UQbRQoBgKDhjHYdSEcNGme/MVOI1LqUCedlebn1vCLqvAE7xfB9FhCWwt/3RIb5h4pKpApXcbVl1CM4q3Bqym8jL9L7emFC/AeAIP7iIZsJsRAkUYh6nALcCOWfvaGpy3afT+g01hf6o1X0HNIiBPHSadT6J0npWAZJSDh7Oy++EpGycmOav2scMpD1YW8P/J39VMu7J2xbuXaJyHOJTnscLxn+dTGlUenDdnqqymc1I/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766146406; c=relaxed/relaxed;
	bh=cpKuuYddT/35x9durSm7BfkKTaEQ/oAbHtPUZNiF0xc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LFwpbEBUnOFcDm4NYnuWV4CrwjO5l80ntaexSC0cu9XvoKNbakcZ2scJxh3W8+QNV1gX3EIf4KjPyb8p6+0p11deaJMZMoc06vFUtHc5IpbJ/OZ0ENESsFyNqYZbRbqOW5/j2Pb+EKyfEorc/3sTt4HQUvs1OvKy9m83K3+10be/QzPKMbuqe/XPMl50tsoW78t1aieaQQD3s9S0Un8txXnSK9D5NcQvmEKdbpgCP2EZ+qU89ojK4/37hT0coeNk+8P/ANXQBQ3mnwQjkEfuLxLsI+PEi4LZEhbNUAnmib1Sjvgh2R7Fe6+bXbKxVSFkPidbA/epZRdtUOBfpp5wIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hSY/Ulyj; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eyGI0Qwm; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hSY/Ulyj;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eyGI0Qwm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 195 seconds by postgrey-1.37 at boromir; Fri, 19 Dec 2025 23:13:24 AEDT
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXmdw3qn6z2yFW
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 23:13:24 +1100 (AEDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJBMLaL1772081
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 12:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cpKuuYddT/35x9durSm7BfkKTaEQ/oAbHtPUZNiF0xc=; b=hSY/UlyjNX3LRsgs
	PbgGdzteVcbM+wm0pe5N8oujULHxWNRFD3VEyHkYEDH8575IUn6m44szYkj1U7tN
	qzJfBevMwpd8xcykmXD2ciGEDDaXVW+ekq/Lq/a+GVpiKC2iyq1ACaesX+horS0o
	rzt9V+WUFbKhwConG4kDKz4/a3uwmwuLlGeKT/OpSuCGHNWqLxZIsg/R3DP6Cd1V
	zdn26rt4yua6hWgLHDln1PUvQMIFs4/RbmCR366AomVye452LsPe+HUbgmFMHfCq
	cyeYFKJvs5NbI60BwDA34PDkffbd/E5x1G3lyEoI6uUk54roeP4ZzfP6dmjHtwuv
	BPVldw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2bjka6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 12:13:22 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed6ceab125so39321891cf.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 04:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766146402; x=1766751202; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpKuuYddT/35x9durSm7BfkKTaEQ/oAbHtPUZNiF0xc=;
        b=eyGI0QwmFvq8ryFG0+3N7vHUoxONoleSrOjjbJZen1hbDqmwz4dC3/7PpLI+pH4Z5i
         2vDgIqvUNCEtOn17sI3KYV/vGZA4ST2zkiwDVg0WLQKnEuEcZSICLgCg6mFNx1sva5UW
         SzeShdh+qXmhM7sIVdnvac0wyBIDsGQ5D3Zq1ipJ85ucViJd6ES+sjnusgP1ux0MAyBj
         BxsghwJFDeGS+42Huy8M1jw1u+riXsAxwBqqTN3MAsY6IYau5SuXtoPo/gCv1MR7vCd7
         IqnavtCYks06KTpdSBbXF2PgXzkFwpXSsCNb7AoD8Ppw0e5zHnGlZkTfOc0zHP1leyX1
         6LrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766146402; x=1766751202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cpKuuYddT/35x9durSm7BfkKTaEQ/oAbHtPUZNiF0xc=;
        b=cFEgElA/8AUT61lXg2b4k51Vlo4cGz3uVFXKf2uTmjwCc0kc+cBmGbYdQt2oXv6Mj+
         e6Iaces0i7mQPTzOu/uXq9aROWfhHoGJjJxiL7pqVJjtOYngOme30hPTqifwofoAjqrm
         7chqEMrNpYuTcxVjsj+tO4mW6y7nU39+6VWlNvdSNMJ2twk+szGMaUrdfoGsxAJUyohJ
         8d9KV7lyaMN9x09Ua1+lMCUq0Fym6bM9OLN2X8hnAQ/gfmdXkLmpyLPvjR9loVafDYme
         hRca6J7KhYMV4p1cTPzR5+4HvW+pLdI7gL0Hp34K2pr135SuVyn+wjBR2+12PWlBuGBR
         ZpGg==
X-Forwarded-Encrypted: i=1; AJvYcCVlfqOgQtEBz+S+rUKF5ON+q5h5mayj/RaZytWL3ICltQCzyHzk+72uE1Updc+GzM7QfLYuQ2vD2x0szVk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxfPGsHqQPSmslUQV1MluplffanrOIlvrGLZKlAsYd+MegGycpb
	E+Q+JyknWX14t3NdN6ZOvelkTlLpDCl5e4B9MUTyrFtDUq3sNcxSOLuCLGZfEfO6Be9pjYv/o1V
	y7f3qSAjiPBcsP4zt2RKFr5qrXxJElhZK0RgbLJMvCN1pWFtTCpf2MjRWeomiUu+cUA+A
X-Gm-Gg: AY/fxX4D819ot/IIFkKXjFknR4vZcPztElIF0kALbpfedLHjm8zTUaAlZJnQ6QkTb0K
	F703yCvPo5wnZYKOhoV7RUSCjdhpx48bt7g6eMyeQgIQBA4Kj0Wx02dUzyzeFdwlz21d4zZXlGv
	zJ0+e3+eFoSw9CVAngdATmJXC4MVDAku6ODJrmKc5oCbvRvZkQ7vAjT6/BfPSa35/cVZFIWftky
	TeYBjCgyPTJVt18hvvJEOtKz5XfbO1ZAFK6knLN8u4HxRdOcRfjYKF3FuZqq4Im1AuY/CcHnDSh
	Jo1KzcxR9HsS6miuZk1ESF2xCI+LHXHg+ix9zHM+P906CW9YMQW6A0Xj3aD5ALrEWVlPEk42jm7
	+KsOyslz8w2IZW/7+kuqAbM4Np13mL00s50Y1qxVgE+J7eIlYU8PAxq5yl3SwQ+9B48d1
X-Received: by 2002:ac8:584c:0:b0:4f3:4379:1ba8 with SMTP id d75a77b69052e-4f4abcd08edmr29079211cf.10.1766146401707;
        Fri, 19 Dec 2025 04:13:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMZuy6OJt454wVzJl9NiQKiuM8hDeZh6vCyymsGnhdSh6+zZ4FAuhdp9gWq5mTNSCE8zMgzA==
X-Received: by 2002:ac8:584c:0:b0:4f3:4379:1ba8 with SMTP id d75a77b69052e-4f4abcd08edmr29078941cf.10.1766146401288;
        Fri, 19 Dec 2025 04:13:21 -0800 (PST)
Received: from [127.0.1.1] (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f48606sm220309466b.62.2025.12.19.04.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 04:13:20 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 13:13:12 +0100
Subject: [PATCH v3 1/3] gpio: aspeed: Simplify with device_get_match_data()
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
Message-Id: <20251219-gpio-of-match-v3-1-6b84194a02a8@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1473;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ALFcaNrjkTb0yqu5k4foi4OvdSHKHGr16rJMG/50MO0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpRUFb0KKYMqc0n6u3g4Eb8w6rsjVgT9ppWrE4X
 /pWcHDcPV2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUVBWwAKCRDBN2bmhouD
 1w0PEACHjq8HZk2ogKTIKiT0XzhFTKeRnhQNUWlXhuuIdHw57FqpYXNOlyB5uI3W2PjErBp2hmw
 fnDSESZEL8yPbc1PaIl9MM2fdzw2qfcmLeDUxqHaz+/jX6YPG917XRga+q2uY0kOdV52fP6v5Or
 jXSJftdeIbmj/ogFmMQdMLOUXTVnlSrmH33MidZtlIT6tjdzq/B5o8Rc0gW4jL91klUL9zdHg/T
 MRphban9QNoHJvL7DAynuv5fkX6LzwpoLc5Cfg7x3TiwFAuey2NghjJP+UPwVe/IX05ZUZBWWNV
 MgsVrxcsSew1ui9D73QsT9aOzfxaYpDfZkTEifq/nH7SE+dJGVHUy/M12Ef9KPlFVR6eezKV5GT
 MpvsQxYtTPM1yv+6akJBVKbfv9BxQMakzIgcMrk23xW3yeVGDkcZxbQxWdur4FsBeVkqrxl9prI
 UUAYRkCMl3M4Que1OQSCVXV0a+h8/JVb4JnE5F+7H4/+bG6CQ8b941/2+sFASknoxXFYLnOHI11
 WOK5/7TDxj2UZlqUEcFZnMZRt7UK5xdIT5443y6XCJ/EmeEsrluxnRuRFa/zRr+fkVgpMOK5hh5
 RvFaz7cORvl24YOswZO6O2ELRaFLt3zPubfd+gvabUntk8hM3WVC0hGBJiLUizRAzurDx7gisee
 /jIQTovdion8pAQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: tT_89F2rBlzA6b1Uk62t7FVMCz7OjaQ3
X-Proofpoint-ORIG-GUID: tT_89F2rBlzA6b1Uk62t7FVMCz7OjaQ3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEwMSBTYWx0ZWRfX8CXacTHg0Qrt
 WQbrnLuwRTcIyF9US5Vz5AhKNCDB1QZRyBj5D3Jo5eqlO4uV3XKm3J/Aeh467XSQOEr5Hr7/HIZ
 tPcpKTIk9/qHoXXvyKZ1SiiqojfZDaquWSd6DnaZSZouNE5TjEuxPv9AjE2XxEEJvUxyZU+gGSr
 dd8yRV6gv9vZ4YNaiw3GmmjqdpJV/z0u+jpT8FUDJGEv6uUYqzWPetaX8WpbFgPL+cynJ7NvWXB
 cIbnQnUEbb4ddk5Shp9SgNEInJyhtnoojYoUvp4lOumdqWa2auHZ462DMnMG+mr0Le99Gp0fWiS
 i7hVTkCvcj7l2Bn/dXYPDauWkYvHk5ipxcCH2jHJQ+G+jrNM4kQFwlXcRnEgpT76YObzXdTOsWV
 zl1W1Em5OB94wen9FdxMJmBXTzugQFAbjsusTCecG1ZFeK7Jm1aU8ZCogNs9xBVMPUF03nllMpy
 m72Mloo9Su4px/1yOLA==
X-Authority-Analysis: v=2.4 cv=WYwBqkhX c=1 sm=1 tr=0 ts=69454162 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=AxvInAFV_DmKQgZoSDEA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512190101

Driver's probe function matches against driver's of_device_id table,
where each entry has non-NULL match data, so of_match_node() can be
simplified with device_get_match_data().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpio/gpio-aspeed.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index cbdf781994dc..9115e56a1626 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -1302,7 +1302,6 @@ MODULE_DEVICE_TABLE(of, aspeed_gpio_of_table);
 
 static int aspeed_gpio_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *gpio_id;
 	struct gpio_irq_chip *girq;
 	struct aspeed_gpio *gpio;
 	int rc, irq, i, banks, err;
@@ -1320,8 +1319,8 @@ static int aspeed_gpio_probe(struct platform_device *pdev)
 
 	raw_spin_lock_init(&gpio->lock);
 
-	gpio_id = of_match_node(aspeed_gpio_of_table, pdev->dev.of_node);
-	if (!gpio_id)
+	gpio->config = device_get_match_data(&pdev->dev);
+	if (!gpio->config)
 		return -EINVAL;
 
 	gpio->clk = devm_clk_get_enabled(&pdev->dev, NULL);
@@ -1331,8 +1330,6 @@ static int aspeed_gpio_probe(struct platform_device *pdev)
 		gpio->clk = NULL;
 	}
 
-	gpio->config = gpio_id->data;
-
 	if (!gpio->config->llops->reg_bit_set || !gpio->config->llops->reg_bit_get ||
 	    !gpio->config->llops->reg_bank_get)
 		return -EINVAL;

-- 
2.51.0


