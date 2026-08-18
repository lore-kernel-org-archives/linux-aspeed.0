Return-Path: <linux-aspeed+bounces-4748-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A732C5DF7D
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Aug 2026 10:31:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPQx25QrKz2yH3;
	Tue, 18 Aug 2026 20:31:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787049110;
	cv=none; b=NO0oDyGhk6eW+ocZde5++GKThVoxe0iHe5otklXtb0TP6Lc5/xw+fIazzVF3kXqOPVSuNnXpDI3QrpHunMaHaE7GLFcGU0wu1LH+zBnZCvM86BobVn24k1J2xaK/2PGJvKpNpgIb9spRx4ewYrJCpQiNOHvMWfF1SamXEsXq899WQlGpRC1vfivLd5WpEY81OCli+XqMutCX9XGm2/2M4hdtsG4kJGwYHQa6YBDGwcamQ2ibzXP2JEUf4gHpBSBf3tihJCVCa+bN1DYOj8hoF1xHdbgHyuOINg7X7mtLW4iIpOCQZ7ZCsce7SHDCSJPvg/CEYjvjivejD1p5WlEcmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787049110; c=relaxed/relaxed;
	bh=SehFAIGV4EScw1eNaWWBsUyEtfJAkEOaG1RHubt8kHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aMvQ/jZVpgGv9CXhaW3B4f1TskaTUhcHbHDM+TiV19R+tTYVKnR35Ek/HHXjcF7yV/oTrU9wDaqNj+v5uWG9VnvLMghdRUvrF+iSkraIGeZ/6sUniN9WuVkFhz0uLcSNpGN+qpKpNImS20QQF8LzbVdOrrBL39ZfbP5QN4+ncxeGSoePW96tE6aT83cd4mmGsvbrqVRRlK7t9HZ1NwEAAxWqVhhYurnuMgwsKvrGemSy4HIomqW+DFffg+F3bjCa8wdo8A5a0qZC9HJYhk55grrWRwgMBNihkpgRLIS/qnL6/ioBSFme5RY6HDTC/8E9CnL0ofWhbPcXvLPPfQLzbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=W8b7NAOA; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=W8b7NAOA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPQx03cYmz2yFW
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Aug 2026 20:31:48 +1000 (AEST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4980dc26022so45241485e9.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Aug 2026 03:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1787049105; x=1787653905; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SehFAIGV4EScw1eNaWWBsUyEtfJAkEOaG1RHubt8kHo=;
        b=W8b7NAOAAX/5CwcYC607lR2r2fFm2Dnr6qQY4c+rhir7EplT8MajQUFuZ2XkJKngyA
         o55fZ9lR6gKxM8+UNs36zv6F7n7VjBdFO8IKhur+QCBbHfQjd7Rk2Nxlr020w2XBDDtM
         gEy//wsG7BHMwAx6hlqEZ3UQdPCFEVwUuJlTwCsQDs2ofqCQttdKzo/Mi+7dLJ4de6oj
         hS4Lz3N2fhbFvr6sRFGntlHzbcOSBa5xCq1lXhtKy4i1OM8JP7qhXte5GA7oYKIhKzHu
         RbnZieAs4A/J8QgR/DKVTMK7JmHcYR7xfE33Utg2xb5B8DSKbSKYAKi++TsBUkHLjddR
         ehcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787049105; x=1787653905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SehFAIGV4EScw1eNaWWBsUyEtfJAkEOaG1RHubt8kHo=;
        b=E5UTsklBJz/7UUM6Sy7qEXHDEsVk5CY/hxPT26CtCbZ3Xye4W+eGLua2TUBir+2m+I
         hrjLEhoun9f9tMU63hzlfcT8uM0qIPzRBT3hPutwW4QyAzoJMkkofYfl9w3B5GEfIK3E
         bvFVJMueailv5nHvv2CI/GdQUxZTVk1DxoXM0B5k6vcFelwjCpxNCRz7xqsSPmLtBWMB
         UCvE54Y4qQPVON5aFWjjneTo5bspdj1hP69qnsLYpwQwaINk/ePpJECgjq6wuONUsUqB
         T2FE02ug5KeCAXQnHe0M07QG1P2R3TJ/NR0h+bjLFOXirRNXkfoVuR3Kl+K4/Cy7GEP6
         hffg==
X-Forwarded-Encrypted: i=1; AHgh+Rroyw1vW7LhuFRlCyAk3LGX+sRjyNzrEJd2rwqNY1nBJ1zhAF1zkTgLPa8Pwa/SpGL36OK+lpjYff0HpZw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw7+LaAFGOeXsKvov3nCL0aaV2o8V0dZlpg7Kjqi/8Bd4bPgx81
	78ZctyJxL0VMae3tF5zDF2fIFaHeEtk/rYgfCeQkEMX5kH5vlo9fsN7YlH8ujpVrduw=
X-Gm-Gg: AR+sD11NZ0MKQGa3S+egBE+u9+nmW3ZSlpTu4pFNLNbhYlW9D+ect+7Pno6GYwWV3me
	s/+U9GmwRUAw7dFStfTLHCrV/hbny3DB61PKQf/uCIvC/xzRRV3lwGMB7cESHUZpy5wlFsvuGW4
	+uk7gwzSMA+/lP4Qyv5OVavW4eBe6fYECO/3Vid+SnY8TfD/um3pj8f7q3CKyqLuGKgI9D1d0UN
	+tdeDWL7X0pJ6mpW9TtC50S8ETFtSlhg3KIbqvtrsZdB11LGECkBnLJpvtQuZ0mHEksn/sqwyeQ
	8B0NLmypdPXgTcQYot+gLDAZ665SCCSxZtT/N5VimGaPMe/FUNpwZY/htCgTSWVut+1I+dlqvRx
	kxB4+QokLxGgA3W5fZJPn4fkrwgihExFDEeW4ozx6z4GhsUcyftyR3IVL5A2D/qvqIjHIsrdeYL
	H6JrXt/rXVSX7Z2sAFpr80vdBQojSSLXZXLiXxvomirNcE7Qr1FPX1BJA5OhGcxfOQs8Ph6yerl
	vFj0NULBYgn0ESBFGWmUIv6CI0voYSIEyQkAuE/TbGCu4uMOxVivjIMoKT9
X-Received: by 2002:a05:600c:3049:b0:499:781e:25fc with SMTP id 5b1f17b1804b1-4998792e359mr338967655e9.3.1787049105086;
        Tue, 18 Aug 2026 03:31:45 -0700 (PDT)
Received: from [127.0.0.2] ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499960988c6sm246025575e9.0.2026.08.18.03.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:31:44 -0700 (PDT)
From: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Tue, 18 Aug 2026 10:29:15 +0000
Subject: [PATCH v6 2/6] serial: 8250_aspeed_vuart: add aspeed,ast2600-vuart
 compatible string
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
Message-Id: <20260818-aspeed-driver-v6-v6-2-fd7cc0b338ea@9elements.com>
References: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
In-Reply-To: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <git@gregoirelayet.com>, 
 Tan Siewert <tan.siewert@9elements.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 mfd@lists.linux.dev, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
 yh_chung@aspeedtech.com, ninad@linux.ibm.com, anirudhsriniv@gmail.com, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
X-Mailer: b4 0.15.2

Make the driver compatible with the ast2600-vuart.
Enable specific configuration for the AST2600.

Reviewed-by: Tan Siewert <tan.siewert@9elements.com>
Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 26fc0464f1cc..6afa2f4057e1 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -560,6 +560,7 @@ static void aspeed_vuart_remove(struct platform_device *pdev)
 static const struct of_device_id aspeed_vuart_table[] = {
 	{ .compatible = "aspeed,ast2400-vuart" },
 	{ .compatible = "aspeed,ast2500-vuart" },
+	{ .compatible = "aspeed,ast2600-vuart" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, aspeed_vuart_table);

-- 
2.54.0


