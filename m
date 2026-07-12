Return-Path: <linux-aspeed+bounces-4485-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF13C44508
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Jul 2026 07:39:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0Sk55y5Mz304x;
	Wed, 15 Jul 2026 17:39:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783872270;
	cv=none; b=ds5vLEOiS2iVxMp+7RWn1am2KpDmw1NAAliH/TnMTveLN44QWVq3RxsxIiPceCs8JkhhXbwYc0A7QM0ID3yJkU/a8H1O3wa5OGzPXr7iG5YsBFiehBgeI+op9gwkUwz3h/dOYH2bOpmBNrUM1RHx3rqP3s6dDUzywV6W51ZdC4asZyw4dBuDjS6aHLkieEZN0gS+qOj6uKOMwo8UIZa8BuKIeYGlvVoTT6oIwPgD9IaH0JJ0nL+Cq0DRVCPyT1RIoth6HlkuBsBDcPfB+1KQZKlfJYnxQXBbmtbqUlPBryjvWGjMr4S+BhR2y9LoEZ+4WaFQK/L1Pc2LvAo3rmCOfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783872270; c=relaxed/relaxed;
	bh=k7WWDimv3b4NdwES6tpNCGufjtNL62BZYyk5PVukc5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QJx7gSL6h7r/zLTH1QYP6f5DN978EmYmTyOEpVrouQuKHNnOQ1IKxuqJL9qcaZ7KZENhKPU1jsXFU8aAHT2JMAmgivBdjoCMFXS14hJZqQ6X88pNT0oKohEennOvXi/c3iWv+4XUIbKvwhIOrSHd+Fzd+vb0y4EdWdfEBkzlsw5Ni8SGEANApEAI56z6AfAqW7zzOYir8pj9GJeBhkHqxJh3OqSESs+CGyg4+7gVPHaf8c7ou80PTgtcTpAe/SGBIG9RtUdXFh+PyymzBntV09G4wkEXYmADU0uDTA0Jc8+AZlPj+y0jNCekeaOUmET2DVDCA5TN+Ihtk0S0gq6w5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b97641US; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=kmehltretter@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b97641US;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=kmehltretter@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gyr3x0KZhz2xqM
	for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Jul 2026 02:04:27 +1000 (AEST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-493b7612475so19020375e9.3
        for <linux-aspeed@lists.ozlabs.org>; Sun, 12 Jul 2026 09:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783872264; x=1784477064; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k7WWDimv3b4NdwES6tpNCGufjtNL62BZYyk5PVukc5o=;
        b=b97641US/+t3ViXPmGP7SI0V5SiHFdYpjiXRnxJ0S768+SrTiWw/jEqkcOcCwH4l/p
         hF1j26cQSOl8QxmFfifO30+VoqPcZ0FG2fRA+ln4k8mZMUq+IHRk9BXNQRkpPMybtFJi
         FLbCFLwzHAKhjnzMeYkhAZJmnEWJ83w90m4cnHbdLDofSsqJdQWmGdozsW8/b3yJ54yR
         g/gdl8nqnsxqLmu4O4SHV4SMWQ5jeof5FKgK5RQML+VkYhRrvrNM4riBs82djfSUCq9D
         UHMcMtFi3Q++QrF82lD0O3Qg7KmmRFADeTaVCFyYXpLJbUvjXPEPKYIl/mR1V88D3FE2
         /2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783872264; x=1784477064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k7WWDimv3b4NdwES6tpNCGufjtNL62BZYyk5PVukc5o=;
        b=qs3PHtKclW8NyfFegmrFL8IkRXQE/XIhRRk5SpG5rlP9bjJ7b0jlM0Lkt8XwMslq+D
         XKEgxGHvnDNvC8juacjN4OBakTHSLnIjy0MURLZF5PdWauNwVzkVSOkjN4R95c9kbzqw
         SAXsVLuFdTQ980RugrX3w2kGLji3aUTIfgAZ4x7ZD53nWfo5sDyzkgPhV5sTryvPnWPC
         OMLlOyHZ1ZImjiRnFh80h5cIA8r3AZoS3WfSLOvK1VgCA+Pbs99zJ4+KsrcjZU5U7U28
         keP4MudosnPqHFTlUxtSslxVPaNSnUQhsWSjMhLg6zfWIylt2ELEPkhN9l8IN3EQekgx
         zS5g==
X-Forwarded-Encrypted: i=1; AHgh+Ro279s8AXedDT8bQAE3I8GhA01d+dmG3rIoy5edq4Of9iNUC11v0P8DSm0qiO0CYzxf1YxTcAM1dg3/VGI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyoojdwzBUXhwfbk68NPPSfuFkt+f8SHk6c0kFQjKBj8TJCY/qj
	aVD7+JckSp/1IDV6CoZ1hU6yzL3mS63hY4li3c9HGUe492bdNSzisaoa
X-Gm-Gg: AfdE7cnccOUN4jHNOQLfV7QnL03O9QmY/Xfmz7glf0gKsmn9ZCIBtcw81pDa/rx9Bh9
	veBjgOJA6W4E21PVDFZHB80fl4oAtgo+giRDVSDVmL3IasVFWcy0nAck0Kb1En1PRX4U/OWgcpb
	HL2lijTyxHoD3aHR/DTmi7/XcelmwAety8jQHndlerqCfHnhS8lcyAm2ymhwlbccEqzSzVmWApk
	TgBmQqnZu5MhRnvbK2jXs3kk8XndugxAryFGZC0+Kec2ZPfdq866jW3//0m9OBfglVg4hLuCG+r
	dWr/EDuFMFF88eTpFWkiloVnRq+9kpranZE/cGaK6Pax4oyV2vAFxv05E+sZteDZLlSwiwPUpVo
	VwlBjQwqy848ONqX0qpG+Ev1UeZ8KX1OjSxyoyzylT8sT3zQ2WjETddHh9T11oxCDecIDjWSEAa
	5i9dtjTNHsaqObYCV5AqpFkJMMpYwNCPcnEdw6aBTdx9DgZfaKX20NkHVnNQz4+zL95jJuN9++T
	0ckGZ1CZLKpE0b47/p/Pssfn0pNZ9ADrMjTBvfDSge2MtkYrtwjkzwz
X-Received: by 2002:a05:600c:5392:b0:493:b811:e549 with SMTP id 5b1f17b1804b1-493f8829963mr60790915e9.29.1783872263381;
        Sun, 12 Jul 2026 09:04:23 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-112-249.95.117.pool.telefonica.de. [95.117.112.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2c8de2asm204774265e9.1.2026.07.12.09.04.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 12 Jul 2026 09:04:22 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Joel Stanley <joel@jms.id.au>,
	Brian Masney <bmasney@redhat.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-clk@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH] clk: aspeed: ast2700: select AUXILIARY_BUS
Date: Sun, 12 Jul 2026 18:03:01 +0200
Message-Id: <20260712160301.98941-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
Content-Transfer-Encoding: 8bit

The AST2700 clock driver also exposes the SoC reset controller: it hands
its register base to a reset auxiliary device via
devm_auxiliary_device_create(), which the separate ASPEED reset driver
(RESET_ASPEED) then binds to. That create call needs the auxiliary bus
core (AUXILIARY_BUS), not the reset driver itself, but COMMON_CLK_AST2700
does not select AUXILIARY_BUS.

It builds today only because RESET_ASPEED selects AUXILIARY_BUS and is
normally enabled alongside the clock driver. On a randconfig with
COMMON_CLK_AST2700=y and RESET_ASPEED=n, nothing pulls the auxiliary bus
in and the kernel fails to link:

  ld: drivers/clk/aspeed/clk-ast2700.o: in function `ast2700_soc_clk_probe':
  clk-ast2700.c:(.text+0x147c): undefined reference to `__devm_auxiliary_device_create'

Select AUXILIARY_BUS directly, as other clock drivers that create
auxiliary devices do, so it builds regardless of the reset driver.

Fixes: fdc1eb624ddc ("clk: aspeed: add AST2700 clock driver")
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/clk/aspeed/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/aspeed/Kconfig b/drivers/clk/aspeed/Kconfig
index ef50481c31ff..2f505eb3ca95 100644
--- a/drivers/clk/aspeed/Kconfig
+++ b/drivers/clk/aspeed/Kconfig
@@ -15,6 +15,7 @@ config COMMON_CLK_ASPEED
 config COMMON_CLK_AST2700
         bool "Clock driver for AST2700 SoC"
         depends on ARCH_ASPEED || COMPILE_TEST
+        select AUXILIARY_BUS
         help
           This driver provides support for clock on AST2700 SoC.
           The driver is responsible for managing the various clocks required
-- 
2.39.5 (Apple Git-154)


