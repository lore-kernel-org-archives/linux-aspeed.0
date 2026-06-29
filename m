Return-Path: <linux-aspeed+bounces-4315-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BB9C43458
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Jun 2026 23:50:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gq31G59w5z2yRn;
	Tue, 30 Jun 2026 09:50:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782715776;
	cv=none; b=XXPRz7AO8lgwd34Rauts7/GQBQeQJLkwlAa7nhZarIfsm4K3q8g90QLi1hF1HWj+q95SwjBTYR7Hf4AR0HRXa2vaNzusbGjpOWtlOBfwjqXkkJM23LEjjxd8xQgKWlmRkSL3hIEDBkhDiIvoapNvL6rbuuZIYN+6FNboa6mnRRmHvzFS7spMPjocRj7XiR+z16BGLQVuyNoJBITQFwRmqdTvY/XErNRPiJj4KoblTmBNZVYQy8VtKJ9g+5gj8WcYuqfhbJXirVs4geCJ8UMeIP9rqaNFi5V1ULPXvGAxrT7QEWpykwo3t+REhES4rr5LtR98eRG5hD94VP2NnZGGXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782715776; c=relaxed/relaxed;
	bh=elnn7JUGC5l+jKw9U2Iosas8+d3MHu6QPBJwE1B2V50=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CrB4auwZxRGPAxaDQYLdArY91F6ZmEa1zScIk/ZxiYZE9WOgLAh1yS2CmmCgTMezToiKqOPuwv6qZcNp1Miq5PhnfRjLGi8Xud/wJVG+lRKrPCypitYsKv5ltlwmCbPiENya9QqBGAUpYIMwH6GrKlIbB1puCHCMfPNMZtTpldDxC9gosyNVTUKfa3OAivQv8dCCIVKhw0jIXOSzyynFAk3TvPlyIRN5rBlLqRgBC75XbZEY2B7FulA09h1AaVgdEvwwjhKOEo2f/PASiKb7EtwQn4RhWDKNRfeRn7CjO8lSWMuuebIPBM5igVOWOu3OgoJhzJYO01xDfeVFcbh1Uw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KJtjbnW1; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+yc_hsieh.aspeedtech.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KJtjbnW1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+yc_hsieh.aspeedtech.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpcMg5Gkgz2ySJ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 29 Jun 2026 16:49:35 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EFEAF43B03;
	Mon, 29 Jun 2026 06:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C72D9C19425;
	Mon, 29 Jun 2026 06:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782715773;
	bh=uq6YWgDsWWGXAC45T6w2Ey4osYNKqHhIwFzNycMRum0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=KJtjbnW1/mqKsn403xVrjfNllzjp/b4KZ0ab99n/OwnpfS7xL3m8NLEypUizpITYe
	 d5Wi+eSF/E1L/X+8EQbNUuowHU25QdOzrPVfJzDbJqqHnayE8RQNg+NiVOaqQEXgw5
	 lqKG1rKaujmOxgeuKulxFFzpZGa3p3f2mo0ccQOKOkAchx9t0XTWDznUQJ7V+HJiK6
	 OKezfWYasXnMr/I2JULjMY8T2erEpk4m/csazqMENxhBparDm86LY/5qE1kxT8562/
	 zixx8yNtgdmcMfdurTGAzi22dMS6nKcnRTBDug9zQtOzBbq+x/nm3THQqHpYGOlT5y
	 agRvKEsmdvGAA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD8FC43327;
	Mon, 29 Jun 2026 06:49:33 +0000 (UTC)
From: Yu-Che Hsieh via B4 Relay <devnull+yc_hsieh.aspeedtech.com@kernel.org>
Subject: [PATCH 0/4] ipmi: bt-bmc: Add configurable LPC host interface
Date: Mon, 29 Jun 2026 14:48:57 +0800
Message-Id: <20260629-aspeed-bt-bmc-multichannel-v1-0-fc23ee337f7a@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAFkVQmoC/x3MQQqAIBBA0avErBswsYKuEi3UxhooC60IpLtnL
 R98foJIgSlCVyQIdHHkzWdUZQF21n4i5DEbpJCNaGSNOu5EI5oDzWpxPZeDv9DTgkYpXQnnlGg
 t5MEeyPH9z/vheV7fNbWobAAAAA==
X-Change-ID: 20260625-aspeed-bt-bmc-multichannel-b44a10ff407c
To: Corey Minyard <corey@minyard.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782715772; l=1578;
 i=yc_hsieh@aspeedtech.com; s=20260629; h=from:subject:message-id;
 bh=uq6YWgDsWWGXAC45T6w2Ey4osYNKqHhIwFzNycMRum0=;
 b=z0YtNlAtfb9bWuZnl+4DCd9uwBOGfUQn+aP+5ndB2O/l5fbsR+oL9XsClEErI4e3dyIgUSw3j
 dcqDi7YaxAXAgEuiRYiZKpRdhR3OWwyOGVjBozc1R3XAZPoZjC4B4Wp
X-Developer-Key: i=yc_hsieh@aspeedtech.com; a=ed25519;
 pk=kLxUeF7g6teciq79it9N3tYNgp3yCspZ+AHlYSnZ0gs=
X-Endpoint-Received: by B4 Relay for yc_hsieh@aspeedtech.com/20260629 with
 auth_id=844
X-Original-From: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
Reply-To: yc_hsieh@aspeedtech.com

The Aspeed BT BMC driver currently programs a fixed LPC IO address and

SerIRQ value for the host-facing BT interface. That matches the original

single-interface setup, but newer systems may need the host interface

parameters to be described by firmware.

The Aspeed KCS BMC and VUART bindings already use aspeed,lpc-io-reg and

aspeed,lpc-interrupts for this purpose. Reuse the same properties for

the BT BMC binding and teach the driver to consume them while preserving

the existing default LPC IO address and level-low SerIRQ configuration

when the properties are absent.

The first two patches are small preparation patches. The register

definitions are converted to bitfield helpers so BT_CR0 fields can be

programmed by name, and the open state is moved from a global variable

to the device instance so multiple BT devices are not blocked by a

single shared open count.

---
Yu-Che Hsieh (4):
      ipmi: bt-bmc: Use bitfield helpers for register definitions
      ipmi: bt-bmc: Track open state per device
      dt-bindings: ipmi: Add optional LPC properties to ASPEED BT devices
      ipmi: bt-bmc: Read LPC address and SerIRQ from device tree

 .../bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml      |  21 ++++
 drivers/char/ipmi/bt-bmc.c                         | 118 ++++++++++++++-------
 2 files changed, 99 insertions(+), 40 deletions(-)
---
base-commit: 493181e2f2f1bdfd4f09a988008653ae73b30688
change-id: 20260625-aspeed-bt-bmc-multichannel-b44a10ff407c

Best regards,
-- 
Yu-Che Hsieh <yc_hsieh@aspeedtech.com>



