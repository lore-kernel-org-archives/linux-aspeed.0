Return-Path: <linux-aspeed+bounces-2351-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670FACAC5B8
	for <linux-aspeed@archiver.kernel.org>; Sat, 27 Sep 2025 12:26:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cYms61MPPz2yVP;
	Sat, 27 Sep 2025 22:26:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758975978;
	cv=none; b=J8XwGsrwfy9xssAWE7CIoFzfzFWM6CGZSZIfg8taEj4twS4bUIVDZvHPti0kbk7Ro3JS3oYAUiUscWh+KPa2ht2wtibgK1zjkTYlA+uqBVR4ZiG5AeB/PHqjLFENOKOXOkUR+F+Nr3eAKFXfE+n8n4T+8Cd5FHztypWLCBJArn59FRiilT3tMFKYZnZWCV3uL7x0zFUToQecaZcnUkzUIwC7OIeqezsK79zMuALc0SI6KFWjW3J5f+61Zoxx0ViLYkLiLR+nAg3patN3c7gCVJtEKiaoLlHmI8Vc7ihp+VtUrzyx4/HqD1yxj4smL7D2CJtZDmTTWOEfb0ezkhtt1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758975978; c=relaxed/relaxed;
	bh=q1CQFEKaI/Sy/SZOKDp8joIn6sS6FqYKFWGC9eEth2o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PmbsFxiUWTOVBd2JSUyk4+O6Y4c5plAFzH/MvkNS/fS3Yw6HKcyBgJc9xUN1moL7u5naHNQIWT21idSSWnz9ykR2nsYSHsQsn8/F+sNSsMTeezQPSdDSBS6a2HU9mieyXr4u5ju/VIi8s12ylyTyq15z/ySI8pt34tw0bhlIpgx/aQ1F4GbQxBZzHyiqyek79T2+p65NPj59W5WuB8+pcVwA1jGx6HLgX4hIqJCtEMIdSGLoEF1bvQVqCrq/zrMXDB7zBZvhOQlIQisqZ8EyVaUhvvu6JZFriZDxsIApKchX2ETcZMd8eqWMA3AXeMht8aelKGbYZs3z92h9N85wvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Ajjl3Uz9; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=dan.carpenter@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Ajjl3Uz9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=dan.carpenter@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cYms415qRz2yF1
	for <linux-aspeed@lists.ozlabs.org>; Sat, 27 Sep 2025 22:26:14 +1000 (AEST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3f44000626bso1884616f8f.3
        for <linux-aspeed@lists.ozlabs.org>; Sat, 27 Sep 2025 05:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758975969; x=1759580769; darn=lists.ozlabs.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q1CQFEKaI/Sy/SZOKDp8joIn6sS6FqYKFWGC9eEth2o=;
        b=Ajjl3Uz9PgTp0rarMTAA/soU5QiiUYGLBBWbXKVxK+mfdvzZm10fddNwID5fTKplY0
         cujqUOXuvR/nrzlv6T91j8z2Y7hhSeWcsTHgmqFyyU2n/THZULzDsP4A12nSBlVnG4ZN
         PTkrPE6baqffa3TCfxRuU2j6VaAe6bSFHd1Z6OtXfdmE5E9iaUdm0w/yWd3cQrRO/Gct
         ruWEyVW5fIizzaxt6IWXL1kez+njLUCJv6p/H41RJoIqApkUwVxEaspdOzKrCZS++X/2
         nmB8MK/QAJFE+lx6rASX6hAAOOlYptht1oadnQ9O59uZIs1kiKCE04kP8CPFp0OD9g8j
         5nUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758975969; x=1759580769;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q1CQFEKaI/Sy/SZOKDp8joIn6sS6FqYKFWGC9eEth2o=;
        b=EU5+zn5OduDtt3aWS7NAle+TIwvjRA1ey8T0vjYKW5NS28dXqTVUS2jxkE9BL594VX
         1HCiqzsz2/oFaXvUJftE35w1KFkEKszByUb7DieFkK/VPaWX+++mi1Ye2wq9XVeYu7qU
         5NYNedC1GWgKxw+ygW7w/ZBZOJG7WQFEVc2+DJ1uupoHgdCH9zjuzYeJkgKiXu9JybsL
         EfuAzZD3ngexeP7AJbmmlocsb8pG3KJh063qfwzTNlc2aKGZBJUMvF8KGMjRbwpqNCtU
         2Y+JmK9vJYQxFSMFYNOMxR+Lnz9W5t/+tZ1TBKKMqk9J8teUTv+nCQHO11nINLqyoC3y
         RDGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgJUQgq77/h+eZTCpSK9Ne89BSBzR4KxRIE6aPWnG2yNJfh7dN8Hu5w6CE5SEpAL4aP1ewWCaZ8FDb85U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyTT/z9eSkho7l9rWCVknCg6SkLf8MlSft9cFqOaM2tOYwnT/6r
	iXAHA6flNOFtiXMWnUd17MnxNJLYj7+aXVApmlIvSOGjSO3osdAadofFBkUhDob/i7I=
X-Gm-Gg: ASbGncvrQLp6huJOpOTPGlQtKYKAiYA/vNLloG7SYw1kMcY8Fbkse3KkGqxwKU2S2u2
	VwjQlOq5fnsY6ealgsdkZHQ3Ul/EZ3IVXrSJblRAsegr2USgydKUJ8bJM1llzUq58N/1CnQZHPv
	S7MPByuXxHoxs6d7ztDUGrYoTDJi0VdnHUMJ678E8rUGgfj+lCxWC7UAsj0XGHwS+y1gcvAhXx2
	iWJXcJevpKXoeA496TdS/HO032dJMQo2pUxqZ7oaGy05zmumoTTqhvQ1F1CIFfRFWN3Nxh/z2iS
	P0qvGO0rkuDUvbxJOsmdM0Y9IzBt+wmPxVgQLu2+R0Dxpt2r2X6uzbeAejk+S/twiDbW7G1mGFm
	feQZtA4xR7/uakylusxFSm9RoM5eBaWlpriPrvb2r4QwEJLZQ6Q==
X-Google-Smtp-Source: AGHT+IHsxb/x4MSuZGgdkKW/ZTkoD1gTaQGZDhqAYNlhS+sWUJEsl7l8ii9uzN93TtclonUe8lxATA==
X-Received: by 2002:a5d:5885:0:b0:3eb:f90a:f6cd with SMTP id ffacd0b85a97d-40e49e728c9mr9989172f8f.60.1758975969377;
        Sat, 27 Sep 2025 05:26:09 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e2a996bf1sm154772885e9.1.2025.09.27.05.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 05:26:08 -0700 (PDT)
Date: Sat, 27 Sep 2025 15:26:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] irqchip/aspeed-scu-ic: Fix an IS_ERR() vs NULL check
Message-ID: <aNfX3RiyIfr3A0ZG@stanley.mountain>
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

The of_iomap() function doesn't return error pointers, it returns NULL.
Fix the error checking to check for NULL pointers.

Fixes: 86cd4301c285 ("irqchip/aspeed-scu-ic: Refactor driver to support variant-based initialization")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/irqchip/irq-aspeed-scu-ic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
index 5584e0f82cce..bee59c8c4c93 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -215,8 +215,8 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_scu_ic *scu_ic,
 	int irq, rc = 0;
 
 	scu_ic->base = of_iomap(node, 0);
-	if (IS_ERR(scu_ic->base)) {
-		rc = PTR_ERR(scu_ic->base);
+	if (!scu_ic->base) {
+		rc = -ENOMEM;
 		goto err;
 	}
 
-- 
2.51.0


