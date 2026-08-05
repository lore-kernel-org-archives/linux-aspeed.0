Return-Path: <linux-aspeed+bounces-4621-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BCAC55174
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Aug 2026 12:20:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFTyb3F5Tz2ySW;
	Wed, 05 Aug 2026 22:20:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785932439;
	cv=none; b=amArMpjNGDnkmXqgNwy2MTnliuxA/VPdHJr7kXTrzER+6OM7CA7i/p/XZGUzF6GDKhiwaN7t0gusbYyJqYruTEdcWZWNHGYUd7q2uZe61/znPHZ9nrvTj2V5j0Oekyl6qyRdZQm4qigPJPKmJDV8IrGW8FRrKJ0A3HOO9oLKA3oDHIfw59Ei673tNcFxBs+ThOGV8x+wYbTEakgyevH3DTZj3Tlbw6/Oaj/gaOo/9Yz1l0zSgqGz8EgpKBm6FxrVNbVx5WMYRZqaMC0GO6RZVV8w+yUj7NRJvKPV0TvgBq6gyyhP488TqrgfbBT9xIJzHHN/OmKJbSv39spCw4l6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785932439; c=relaxed/relaxed;
	bh=43Zhfg5+4+Z1uzvRXKb3yHpIvITffod/8Jre6ZQvzL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LA+3TvGeM7wFd0PeDKsZPb9rO7nvUkYssmz5ubT70QVFks0ooSgfAPjPTvKneeyPNDTfatOOw1SpK+fMigosUvEi/tAXkFkq4I+aLxFaRnQHtuDwObzm5fHBOgOsFWuQ1nnZe6rlzrDp94jNyLpCsypMDmHt2wSWgtDaKZFSa3gBCJbuh2Ub1+aCQOpCGXazFsplHSouTtk9/ykPj/Il7OHlk6ppJl4Wl5dCCr9rirSFV/A8ThptKOH6KsmtATY5k8bTLGFsn1usEhlGJatLuShdZ/jX2oaB4xoXWl4ERLotFPiZfmELS35Cox2En5wPLVbOKz8f4fXxB8yA7dc2Nw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=MnZs+sxZ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=MnZs+sxZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFTyZ3x4vz2xqM
	for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 22:20:38 +1000 (AEST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so8843905e9.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 05:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1785932435; x=1786537235; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=43Zhfg5+4+Z1uzvRXKb3yHpIvITffod/8Jre6ZQvzL4=;
        b=MnZs+sxZ4SsgHnSmtwf2N77EGuV9oL0k49kJ0fxYgi01D7Y8WCtpF7io7qoAU8AvIk
         On0VGfWVNzAcnRLyYXYvtqCEYHxGHOX8i7ByHVpHr3UmyvD/wjZ0TKyyWmYTGRfeeqzS
         6grCtQhP3zaMQ/iWBiwxOOkjZjfwK8B/ZYE0kfeUq+b1IBjUwt8AOOzkOIyevFZWhZzM
         IKROCHQIpSBvLZG5heSOYp7mI1SY5hpolVPXNbRe2zTSR7RWatjvjFNLd4C9EG3c6Pgx
         dwTm7eH+5QaOctkHQeu4PAaHnRn826kKpksXFpocA9YDY1s/Zp81Upbr+A9sBBHPUXEO
         tn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785932435; x=1786537235;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=43Zhfg5+4+Z1uzvRXKb3yHpIvITffod/8Jre6ZQvzL4=;
        b=sJUTbgvQtPj1BB9xzrpA2N+zzy9dmeBlM41r3Z6QZ5CVr3uHoc2Ka3yBjCWbFCnDfb
         Ou7qo4ehGZm+fGD7i1Eop/HjzJcFrjmnN8oDTuhI9ZThN0ZsNkJTO6oTAKDiqk4rgHPW
         XWRhwt/5JTA7qoX9gtnb9iGpDLtU0+Ws/smiaiDefBNr9W5RAcgzk1Dcofs/Svfo5U7K
         3cqj5Bq3YeOdbJbqBqdMYDxMaMw9St2Q8844UGcpVbD7BrGNNqrFtyOEqXdTeVnvgKIf
         PBAj8gBrGvNHY1W7S55x/f3MntgZwnYPCZErJ20vGWpXmXKieueK5/TVpRitToOpF/T1
         aaMw==
X-Forwarded-Encrypted: i=1; AHgh+RrFykyvqWwq7ACJc+WKIYmO70XcWP0Q6yVJfXFCxal+94ZnKXXy647kS2Xkx0GEI1Fj78w4bcKcO9AhyFQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzALd932I8KGmd4LZdQXbFB7TSt206bGlPn751P9mTFdcuDnKKD
	20RM+NoX62ubdWbGB2vEOdFX/sLCQK56SxV5EFwD7TWDKtumGqPnRbnhfwsjwjqLOBM=
X-Gm-Gg: AR+sD12gVaIQKqHAjRiJmtzfLlHqWP2IDywQh7KbUya8pGI5c/iwoCGnj8sfMbli6z6
	LmBZcImD7mbrkTeu/mMbe5pPXmFFd4Vgi9/ZlNrRJ92xEiwgpfeMgxUTHZtBbXvYO/RZZXqFeCy
	C4tPE5FfIbi2rOvZXR7/nFZbiCTQLpKnR/vHawTzpvvbonvBII+6mgn3uepJHjHOq/OL3iTKU9g
	RX1/zBnUadu9/31f9Z+J8f6ty0kZKjn9o9XXtkySSr0n9hi1m3CuJDEAbHcYjWihtcGJWhYav1v
	Ap2ts8tV+NpoDphmXA+7Rl0BWP6XfhyH8JRadvOVnc9P0586SYjOHVuvJIqFimThsEyMpNO/wgM
	TImRNfqM7gQ4rpQvSyu5oWuj6+Z3UEERCsVJULrUhlFlnD4pIa4LLQ4rnUDKZINAGgqkSDs1UIF
	nxetBS+YpX6X41fu7T1N6vrQqnWa+TDK/4wtHFMquLC/ZjrZBNTRilAT6UIGddsq1ZHTleiVBYS
	Kce7z3hIcsaXXEXNUdahcrxMdJ1ZPeRumodqvBuWdYDR+AwBR/Yw1/D+dmqesGa+7Fi6zx3lT8E
X-Received: by 2002:a05:600c:1c22:b0:495:734e:4825 with SMTP id 5b1f17b1804b1-4994e7dcf28mr67408645e9.16.1785932435246;
        Wed, 05 Aug 2026 05:20:35 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949f68f95sm196663515e9.0.2026.08.05.05.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:20:35 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lee@kernel.org
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	anirudhsriniv@gmail.com,
	tan.siewert@9elements.com,
	linux-serial@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v5 2/6] serial: 8250_aspeed_vuart: add aspeed,ast2600-vuart compatible string
Date: Wed,  5 Aug 2026 14:19:49 +0200
Message-ID: <56aa0a5e26ea76e4f9a27ed059d2b05bec9cffa5.1785932211.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785932211.git.gregoire.layet@9elements.com>
References: <cover.1785932211.git.gregoire.layet@9elements.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make the driver compatible with the ast2600-vuart.
Enable specific configuration for the AST2600.

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


