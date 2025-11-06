Return-Path: <linux-aspeed+bounces-2793-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5108CCCFA19
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 16:16:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2S4V5Mw9z2ySP;
	Fri,  7 Nov 2025 03:16:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762445802;
	cv=none; b=W1Um+J2Elqk0pbKjme6WKzK+1Ebn+p/EVBaJSw5hEs3N8UCikYz3GOSPQQws7N0tkt+javXTaJ1Nzc/wFUaRld6UUXDiZiXkRLMVbr/BBmbAyodiXFwL89bQonHJ/a3dtA9N1mXWXMFewP0g31gkdoYhuDxSMTdtqvwd1p+mZjIlJHUTs8fsrglDSpR1BS7ib7k2hb5E32uKa29PdHcJbepmYzrle36wgNhdWW5a+8hiE67Ox61GKvwfIkvyQFYxTtD4FCLpHMlPhbZMiTC0rYklCR4k9QPmZ2lan7Y3Rmo7SVwHRfZSsJQGdLAOXfDKo92ggJiOqheamJ4IZSn8Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762445802; c=relaxed/relaxed;
	bh=a/cWESJHLQuQfZBepHMhOg3dPVBwhTpABUd40+CP0cQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jxPXI+r0fCE61nV/T01+fBPPXKGNM2XioJlx1wGoFpRjT5ivTWPNqFYElySaiQrs4p6q8ThwPGrgPkonzCDGr+YkpxOTeR2MZFJyjhXQYrXMDjERD8GGdK1itXWfcisfVrkFxh2Fvny1wakbdjEDd9x0Tsbx7BE+JPLPrruRkGb8d0c0s0ho0ls/w0EUDQuKZje3Zo1wD+hIm4zJwTQab/9bqlui0kbNsf97IrB93XDDnSAmFlsvnH6fMMHCA4QYOSls1DTt+V/BriUBaJigmMyD2mmvl6SptuHt/m8VI4BSMeIqndVKr8FFuesYH5qrE5hYtYHFtOFYNrcvDRHFPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ksXZ/I03; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ksXZ/I03;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2S4T0L0Gz2xR2
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 03:16:39 +1100 (AEDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-640e970598cso210781a12.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 06 Nov 2025 08:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762445796; x=1763050596; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a/cWESJHLQuQfZBepHMhOg3dPVBwhTpABUd40+CP0cQ=;
        b=ksXZ/I03GZxYhm7Alj88UdYHCFTwiJRhBLdEZ9yPtYNGRWrUhOOqQTYhh8VefcL2Np
         B55278cErevFZnyJz8gVXZ6PxLSMY2i7VMY2bPYKJtwhKioCvy5ipAog3nRz4niroIoG
         M9kMdkXDC6gyqP1AUwHYDJjmT1jgQvsW1vBaCBrSzVMmYZklsZQsGh4Bfzwk29uT3UOk
         +uXqpgqyzzB5+XGW0OLcxT/1KxaNOC7dBYtmHhUyuZ0ccGYqin0F/TzqXET0Ek7DAKaO
         SRCPego6YMBLn8RBjg3OH7R0W/VykEaSoTI/hACYrJJa2CA9tJV50xMikkVxVZ6vbZQ0
         d+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445796; x=1763050596;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/cWESJHLQuQfZBepHMhOg3dPVBwhTpABUd40+CP0cQ=;
        b=pD62i3W0ncW+RsPuTFY1m6lsiJS8oDnLNfu0/XmcUDxtf3rCmWaSXmWTydAqt29Z/K
         ux8tv2rqf3rNWl2H4qatU5rz1nqdy/lhjQ+ZCvRYqkVBmGtUb4wRHdZuqiGbuETZDjPK
         zQyuRpCMZeSgSoP3n7mZ9/RNPwWc7O1yK2TyXvse/GV42FrgBbwnKV0H0nhlyBVyZZhb
         ua6420SOPE+PeYLbheR0ss2IyzIDsVmumWtgoKzit1umT/sn+Pw/Lk7+EOEz6U3ER4e6
         AF+9HHeOrtU0eiFg4gGbiYGZf5H0oDgiqdqamENxJxPUAYmuGHldzbevZFNGzyDCK7Wq
         DyOg==
X-Forwarded-Encrypted: i=1; AJvYcCU7UtTbWPpqlvjBDf8FBt7JaTtILEGuyZXr6GxtrUxEOqr51M86gxPr2BVSViGA6YZ2n/sMaM5gYygRNsQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxETC7r499vHxxLFd/U9WDSafbpy8Yxk6+NBs9deT6ENBG1fkyU
	z/JhX6OKKeIOzjaTu9/MFI0JBkUu76mhDJt5lib6IcJxTJ2NTkgS3zVzWGgoip6SYao=
X-Gm-Gg: ASbGnctzm1PsVtVBapZARYTqd+csqDutO8mfN46ccCNXibnLEiVXafNpbe59SqCFGQx
	lv+up/xiVGHrrn36STrBjW0yWcokUo54bnTbYLOWUVzxiFuJk5LwZgweCEU+nDnvm8eEsDhS6Yd
	WbanvH4snRYVi5UpJ06FM0Fk2gBrqUY7pxxKOZ9k4tG1lGHxPn6tUWsRUz9r6y2kRn/GvW/H2VZ
	j46xIqcqPTs88YOmy9LCV0WNgxX1bF0gGGSHREULul6VYyPKVJpy7Az7QCvI1YfJ20NnXEcBZUP
	AOxMCvLQC7nzZmqaNDD68Xetxd8IRZdoVG3UVRHzokuens3OTF9fOzo+OWo0lClXvEWrd4ITIO8
	Drl4C/At3Sx7hpjpsynH5A5qhZSjwDWXmDxZNZQPVVplVe+T1EkrR2TAc63Vtuw9aQcPMOASwiz
	3B23F04U2b7THthLWuPTyVEsI4Z8g=
X-Google-Smtp-Source: AGHT+IGZyiotRhhgwXYn5kLA9144yJt3CqLXWRIlBplyMOGLmU5g6JzMcGZwLmbbAR1KDnNe/CJBWA==
X-Received: by 2002:a05:6402:40d5:b0:63b:f26d:2eab with SMTP id 4fb4d7f45d1cf-6410588c64bmr4342221a12.2.1762445796238;
        Thu, 06 Nov 2025 08:16:36 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813eabsm2113408a12.11.2025.11.06.08.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:16:34 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/4] gpio: Simplify with of_device_get_match_data()
Date: Thu, 06 Nov 2025 17:16:24 +0100
Message-Id: <20251106-gpio-of-match-v1-0-50c7115a045e@linaro.org>
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
X-B4-Tracking: v=1; b=H4sIANjJDGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwMz3fSCzHzd/DTd3MSS5AxdI+MkI5PklJQ0AzNjJaCegqLUtMwKsHn
 RsbW1AKFqXdpfAAAA
X-Change-ID: 20251106-gpio-of-match-23b24cddf063
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
 Srinivas Neeli <srinivas.neeli@amd.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=m+62ZdK0Lq7jNUHc6LhXJD8r2Oz0NXj2Wf/sdNqZaZ4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDMnawcy7CZrgSJdmsX8aGdzbZJXfoTmd5wcte
 EXUkZPJykiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQzJ2gAKCRDBN2bmhouD
 1/GKD/sGaVw4KqMnqsuf/Iq4t8i+hgL/3lnY0jK+9SSHdXboQ7EJfgk3Sm6wY52RTR+tUedRqHb
 KgFgHA/5ybPQRwhsYIiMvznFthIaKAJQOyqKUk0EoICVUmcd41lh1MD19gMi8bXpb3tdhoMD0k7
 c/ssi6l4uvZwgGAsZlS5xpcM45nHBvnKd52CJW6DphNkNEcv6mznj9RoO4xwAw2YNkPUXcVyTOG
 /Iz/TKqD3SC4b4ckdDh/LHlBACvBtj9Ouh4a5kchOc7TvE5K8NOCIstjaGA+VYGTt1gRiqOI/+l
 GQhTiL2jKs68Rxvm8cnU/28TKbJq/Bw9/SAaE3R2zYyzd/A1OyqrCHb7kIjtg1T3G4jVK/nX0vG
 UI037XTHkPBuQj9xet8T8YsCEgsT8xyeyDe8LnAmiXykzytmOzkEhUszveFit4ZBFp/JOdCMSpR
 4ar2NyVFBRiYVufNe3lzr2S4DZPoinPKdKdRJfZ7twvu1E5rN3Ptry9kUlKmFnc6rDTTJA0zGwJ
 wcvX7YTxJiaMdZgmLN0y8Wh9a8s37KEQWrJAWQqcPFFA3o9MwAsGR5QDYRHuagOmkCjj2MmP4QG
 9giy7q8+4GvJ7VWK3iCZ1y37exP4A7BdriM9cp5obCaixlPiHoWi32+FRChQSaI4HfZ0l4XcZga
 V+lfSKqaELeCsBw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Few simple cleanups, not tested on the hardware.

Care has to be taken when converting of_match_data() into
of_device_get_match_data(), because first can check arbitrary
device_node and the latter checks device's node.  Cases here should be
safe because of_match_data() uses 'pdev->dev.of_node'.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (4):
      gpio: tb10x: Drop unused tb10x_set_bits() function
      gpio: aspeed: Simplify with of_device_get_match_data()
      gpio: creg-snps: Simplify with of_device_get_match_data()
      gpio: zynq: Simplify with of_device_get_match_data()

 drivers/gpio/gpio-aspeed.c    |  7 ++-----
 drivers/gpio/gpio-creg-snps.c |  4 +---
 drivers/gpio/gpio-tb10x.c     | 19 -------------------
 drivers/gpio/gpio-zynq.c      |  8 +++-----
 4 files changed, 6 insertions(+), 32 deletions(-)
---
base-commit: 5892a3d1e4764f041ce756d8f8b321d2c92f653a
change-id: 20251106-gpio-of-match-23b24cddf063

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


