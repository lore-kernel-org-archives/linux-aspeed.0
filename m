Return-Path: <linux-aspeed+bounces-2505-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D008FCCD199
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Oct 2025 16:04:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cp8lx5Rh4z3cZp;
	Sat, 18 Oct 2025 03:04:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760717085;
	cv=none; b=WVag4xGphDEckQsY8K2xnJXZ3Mybr67jYU4AlZuRsfVsksff1inpRGq40iFSAKhaPXFhJy9ffZQKXBlX8HmyK9gB0+D4AwJYc6ytxowQmMwrYMeoNAUxXeYbbryCF7iHFoV/kyknqVU8peJ49/60hG76nIRKA6mq8l/9YyS6vIT/dCdlZWW4YJC4XiVTrvXRfATgR2P+KSasdEDwi/IBqqdAb+4YOY4MqzAkEsRMw3SUb7+8UbIjLQgQG4ggWjrz3xQ+gXvck7N7HEpcQXd2HTf3Yxjda08LEuKkq71TWNrN7NyZAsyhd53Yaz9K9htbjekHUnQQsDnRE13foiG0wA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760717085; c=relaxed/relaxed;
	bh=950Q3osvXfNrhNZDR0R7N+wo2IA1yL5cHorDQTcIxKM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gNR64szxKK3lwD8QIhdF9Fc2jffwCGtQtJjT2ccS2tWArW0eMXI37cKHFiLaJvwilinijZvjjvw4XDqVvbLwCNm1DWRPwAPscVuqnmjHWMwo6szc5xE/H3YlhngXk8JlVMtKK5oxwLJJB+Iavx6HBnHYdDxJv9KNhRUxuRasaxoi8roBmoZEWUjveRFtbC1XmuXbl2V8/8CnShsvtZdREMpFcx3tOQHGFuqr+VNXvZGIsv7ujHUgiDFeoeHgtnJM4/GmNp9t91dJ5pHfDtzQ5gJtpdS4N/xBt3mwumWMgdHH0NZWaRMd2eV0BRXFciJsi9bEccVmesCfqdi8O93RUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bJjB5iZg; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=dan.carpenter@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bJjB5iZg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=dan.carpenter@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cp8lw2mlKz3cYR
	for <linux-aspeed@lists.ozlabs.org>; Sat, 18 Oct 2025 03:04:43 +1100 (AEDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3ece1102998so1626002f8f.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 09:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760717079; x=1761321879; darn=lists.ozlabs.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=950Q3osvXfNrhNZDR0R7N+wo2IA1yL5cHorDQTcIxKM=;
        b=bJjB5iZgOJweep/aSjXru1beh3bMdFhoc3YadB7OHWFc2ZUDURrkgJijGEsI9/zaG7
         7vsk8L9rcDvvDcl1zbkDsngW8irzHuS7/GqxXPwZlMxyBU8cyeGp1a3c2B2bGFdjPdvQ
         Y32koRqzQLY77kqxU+zKsvNsUoU0xJY0eDpzBYC4G4ScqxkAd1q85lTCJaYU6UhJiBr2
         tI1s8Bi0QHNhjkvm7mH8V0mniU7HwEYW6+q2rTH7a+ZduRTA8PVW5Jv+va+cB1c6TR1V
         +2GvXHXpGHPH1yeGv/xc0afc7UGKsTQQFUV4q406wCurkwORKrX12nXjlFqV9+UQUK/j
         FoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760717079; x=1761321879;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=950Q3osvXfNrhNZDR0R7N+wo2IA1yL5cHorDQTcIxKM=;
        b=J86E+1p4FKMgpKQRqkM8H4zlE5PkzvxuxVcbe8SOpKKbvmoLzDdYhoFededrut5ADG
         hRYXA9d2PW/yov1JIutcQON76tFumFU3Ic8gWe0QQHQy2hAH+L6GZwVNtK65L3DOvvWD
         JCxCASpLThTFD0gQI5pt+q5x1xPG7bfjm63JlyxZaCaEiSkTBWzBCIWL4nmOj019l3N8
         73e5nXz2sNOKqcQ9PPjqqbOVtjaanzNf3o+k06H1FCsmQyCFtTAlxQO44cKrN11MLc67
         rAN9b+ugrJ1jfc0p3DqGwUxPq0HEM5y7wAGtLWe4xtNs6mYAj0KWj8rs4zeGjCxc7gNW
         i/XA==
X-Forwarded-Encrypted: i=1; AJvYcCWMWxdzgdNcpXRRu/XH5zyI+ey4mFYmODk4vo4YElNISg5G8XdIGALgMDm40g1Rsgc7hRD/op+2vMQHmBU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy4zAV4tPAD7eMeEC5hzwX285QFaNqfGV53kZkpEtcA5E1wc/PB
	AGpwvoxyjkZsayf476wyleS0+O4JD8DcpDy8AczLza7D07En79MJDJPeoDVV5USS6WQ=
X-Gm-Gg: ASbGnctpIaaSwXdPqiUaCvPhxSdBO9kD86+/G2o1o4PFrEf+cHUYwwNy0uRgmJETpqm
	xhTsEbF1J27vvUYDVGWV5bPP228kOMxoh9CeZRLcFHBl3vkSEw81vNNdsw0ySzsU9oOiDBmmiuN
	Erci1ZZjk3c5MqvNDuC7FeV90VtU6wI0wapePA7zwSNoIFhq27fDob6O9RW6zzwJb7OYCBxWjGA
	Ic4R7zS3Zbk9XXMEm7Q7FuUI7v3yR6oIVnypv8qUqovk7EOt8F8xef4XSyqVQjU7hPV7xgQR1lE
	telehsRwWYIU9ohY0poTZWmdPuC73zCikHqmhR65jAD0emHviKaBAYKY3N9V3nwHrAgrvUwpi71
	1/0h/74I4XMWx2CU/DKLAKQMGhmLIuqJYQ0oCFFAlFmY7qbIClw3TL49VCiEQ3qiibt+QkTX0OV
	SXQgaMRg==
X-Google-Smtp-Source: AGHT+IEqaf8aEdQodsl+JMqmg15To8fNumQ1pcFMtGOlWgs5DrBRbhx4c+4oaiAKATvKgQ4yjwGtCA==
X-Received: by 2002:a05:6000:26c5:b0:426:d72e:9924 with SMTP id ffacd0b85a97d-42704dd6cf9mr3110630f8f.51.1760717078511;
        Fri, 17 Oct 2025 09:04:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427ea5a1056sm544f8f.2.2025.10.17.09.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:04:38 -0700 (PDT)
Date: Fri, 17 Oct 2025 19:04:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
	Mark Brown <broonie@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] spi: aspeed: Fix an IS_ERR() vs NULL bug in probe()
Message-ID: <aPJpEnfK31pHz8_w@stanley.mountain>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The platform_get_resource() function doesn't return error pointers, it
returns NULL on error.  Update the error checking to match.

Fixes: 64d87ccfae33 ("spi: aspeed: Only map necessary address window region")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/spi/spi-aspeed-smc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 0c3de371fd39..822df89cb787 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -865,9 +865,9 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 		return PTR_ERR(aspi->regs);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (IS_ERR(res)) {
+	if (!res) {
 		dev_err(dev, "missing AHB memory\n");
-		return PTR_ERR(res);
+		return -EINVAL;
 	}
 
 	aspi->ahb_window_size = resource_size(res);
-- 
2.51.0


