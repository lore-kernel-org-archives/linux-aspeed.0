Return-Path: <linux-aspeed+bounces-3523-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02E8E9A02C
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Feb 2026 23:11:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fGXLn3WRrz309S;
	Thu, 19 Feb 2026 10:11:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771402608;
	cv=none; b=VlN5/aOLVSuw+SI3lIuNiv09oosMvH6uvuVV/k5OK9iFquwxLNsqB05g54vj6Y+CWjBzTbxWDWIA4vEGfRA+ONPBoyLjeOlDQ8PkhCkbdEh73iwPY8GQnFnJOu9d96akqL4Qy6RGt8bPkfCIaYKEKiIMglf/W02Mx31ApPK4yARQaowvljLTiIR80eQ6t/pPpN+g/gdK4yhMEn5DiprWCxCGeiUTyPFu6/yUPAwQy5r6ekO7Z2OQk1K2z1HvfE8421zeWvJ77rurNVNns41o+FmweBlzyWgQrbWm7HbliQuMowdhga+jjNmKoD3IJAajgC6xqFmW0FlWOwoytWlPtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771402608; c=relaxed/relaxed;
	bh=o0bP01qFBrwLQV21WFsuN0zM6OdwGcJ2YrdhXKOaIYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZVEbKxZPkgLhbAzL1Gl+v7dqtyng1BqlDArOmTR7dciS+AmX2LpyVq0QA0hemJyj6GH1dybJ+tAGvtFb/KlBkRxnS+35TJhGLDb+jP6xxICGzg23xA3mkmWanwiyillNKmscj8WRtgK1nw1DM6eJC4cEqjZ0yTJXDyJcPqvxJyqTMhjiTG2f0ryvJP/6HETVBvAwgqGBP+pmsguewgVvd9Wuu1rWVi/ZEt8akN4+nhzpbPWMEhNbkFDqvtDqyk2zVE/naitEjrQWuutYWjqZeDxW1OujFfNJtbGs1R1+lmildlS48GHjoUEzsI9+FmGIbfE+xJVqNUeI2bXP1VSmjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=d6hFZ69G; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=ustc.gu@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=d6hFZ69G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=ustc.gu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fG8Vl0svpz2xlk
	for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Feb 2026 19:16:45 +1100 (AEDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-82361bcbd8fso2487445b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Feb 2026 00:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771402603; x=1772007403; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o0bP01qFBrwLQV21WFsuN0zM6OdwGcJ2YrdhXKOaIYw=;
        b=d6hFZ69GfUlWGotJzOBw8ILSjCgPQd6kRb8eVQRejAT9HgaKyiOE5AWZNHMhpByABb
         IrbbTdivHgHW/ggngTIX4n+kjSv0xo4lE/0WCTm2p4Bnjh8Pr0Y9I9jhuSpBlCstNMQt
         fXVKwRAJq92ijXSMk6NfaL3l3VEX41nA66sRi4TT+9OHQum5DgiF3ab+Z3eYz5JfDoX3
         F4B9KzRMm2ydtak017W99oorjK6sKb0r1UmrvD83x+LW0eVIGLJhdJpuWY08jHyoaU/B
         RIkcw6A5HPF3DkHT2GJRRiLkMdCP9+xHSCEEXKHtPiekUTfpFAoli70uN0qKasF+DmYS
         qNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771402603; x=1772007403;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0bP01qFBrwLQV21WFsuN0zM6OdwGcJ2YrdhXKOaIYw=;
        b=tee5xqrdmySYhQDDkplspwK9JkToO/X0ZxttGqXp102s3UPNv8daTSYJe6yeBzyhCJ
         NCcym3pCZf6S4mnQNu9JNdrS9JM/cEQFcSWMIeaRdLtBtSrbcRo14Gp+cZKqQzVQXKdJ
         6iruk5D6+FF2Dc/p5Lsl1/6cNRUItUOIFP1tFbO8qb605dohUrtr+tVykhnFBvIFUC2C
         14Qpoe1GoHkKXhjElZr42NWtSJB5H9pF53rNbh++WXgkk20ocxp7NCYxHAYyw8BGFpY6
         KxZvhk3xxIEfJZ/ik1YEdbs/1pcApAxgQ4ujJeOmOZBruuCiD3xRRrAPfSoiu6XN8QU4
         HQSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx6f6zviSCDPUtsG1gq/wJU7/JfI23Wv3pp3aYWPfIdPHE0gLrsea+N7PK2M0bTaAaMx4r1zlYbzBEGqw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyJP6eOb7x8vt4NNjIQXWgcXI9Ekw8hyr8okIvDUGe7VZmllPpk
	7nDmLiq6S0UX0ZptitaxMTKCwHbeQac6XG7YpOB/t05HPdwwmnDOxaLXTHJtFU9j
X-Gm-Gg: AZuq6aIu3qR28baBP0UuCF41CyXJCJI+qONaQR9pkv1Owfw5hgO6/qAXYeRPDtG8Bbq
	REKAL8TBdA4g0bgRDEqBg/U52zp6AY1obkQWhJltvRvc9X+Fq7GZrVC6GtL6AVNkvgtgq0+lpSC
	fgcQi+zGwASuu7m+2ORthv6E+fuhpe8piWgE/yaFy7/br9v6P5cnlJHOrsZt11aWkCtP9PVMKkO
	FIoJm9bXzEp8MBFkFH/rG+qXQoY8Se9/bwIJ2N7HX0a8HT1b1lG5sv41PpLt9qKc+NdvEAaXtQw
	kJnJl508gObqjtOMWB7MyPQ+sMb1JRD+Vh0DpydL4rhSTUqqarOBsYqjOIATkdpvfsNwVi9mIxC
	Qb7kcH6G0aJvxObfgI338yFNARcqBiDf7YetKeCZzYtG1n15/efjZJDUO8VwMj/5YS2KRbcaSJf
	TTuLLYRkuDhUkvKpHUk9YQ1Z8THOeq9Bn9kFgZ
X-Received: by 2002:a05:6a21:748e:b0:38d:f250:7a79 with SMTP id adf61e73a8af0-39483780690mr12105647637.15.1771402602733;
        Wed, 18 Feb 2026 00:16:42 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9008:ba52:403:e988:3f54:236b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e5331ba14sm11966535a12.29.2026.02.18.00.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 00:16:42 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Wed, 18 Feb 2026 16:16:37 +0800
Subject: [PATCH] clk: aspeed: ast2700: Add missing NULL pointer check for
 devm_kasprintf()
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
Message-Id: <20260218-ast2700-v1-1-2388e0fe3597@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGR1lWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDI0ML3cTiEiNzAwNds+Q0C/OUJHMjyzQDJaDqgqLUtMwKsEnRsbW1AAt
 +zz5ZAAAA
X-Change-ID: 20260218-ast2700-6cf87db729f0
To: Ryan Chen <ryan_chen@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Brian Masney <bmasney@redhat.com>
Cc: linux-clk@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771402600; l=1056;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=ATLkbn8TN+9WkJGc0zUgyg102ukNwiK3cRL5DAp1VH4=;
 b=mbhAFVh+U+0K5i8+MeMwiZF5g2QdlgYBo36O8enjZLUm7iFq7+Vaki2aS8uPGORp5U/erYDXe
 TirWXZT+NRjA8lBL1zQsJf5Aq5gsMXEhCXt30+bItwC7kLUzMkRglut
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

devm_kasprintf() can return NULL on memory allocation failure.

Check the return value and return -ENOMEM if allocation fails in
ast2700_soc_clk_probe().

Fixes: fdc1eb624ddc ("clk: aspeed: add AST2700 clock driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/clk/aspeed/clk-ast2700.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/aspeed/clk-ast2700.c b/drivers/clk/aspeed/clk-ast2700.c
index bbb2b571eb72..011f8be03edc 100644
--- a/drivers/clk/aspeed/clk-ast2700.c
+++ b/drivers/clk/aspeed/clk-ast2700.c
@@ -901,6 +901,8 @@ static int ast2700_soc_clk_probe(struct platform_device *pdev)
 
 	clk_ctrl->clk_data = clk_data;
 	reset_name = devm_kasprintf(dev, GFP_KERNEL, "reset%d", clk_data->scu);
+	if (!reset_name)
+		return -ENOMEM;
 
 	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, clk_data->nr_clks),
 				   GFP_KERNEL);

---
base-commit: fe9e3edb6a215515d1148d32a5c445c5bdd7916f
change-id: 20260218-ast2700-6cf87db729f0

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>


