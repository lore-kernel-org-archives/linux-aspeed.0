Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E91E606A322
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Nov 2026 11:58:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNSwJ50Khz2xdb;
	Mon, 09 Nov 2026 22:58:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794225488;
	cv=none; b=O7rKopGjp5UZikBTTDYLO6D8iwoHy0sIk41bt5BXWNd3QGkLRPTRQeCXEvh16vn9IXuNHU2opNzTk5FJw547p0Fw8z8KTl6M2XODtI4df1MVBYvyxyLra7ZvhrtYmmf4bVTMUNF/fmPgCO1lHahepCUcFI0YDFAk6g8iJAOFxfu02o6BuvkEC8aGYSHEtZw088vKsao2fyA9obZMyFu+f53xnhsd9+/7kBsHiyWEWbkThIcBawTVzek07eyUorA3pWWRlsPD7wqnz6F0h1JwmwO2+atUk2roC05TrrsG1wKAuvjf3r7VW0vlK3G/N4WzOaqh8KNW++8RQvpbzcWgJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794225488; c=relaxed/relaxed;
	bh=3LPJ2HrlKN7oBMUZEavDpBpJi9yr4o7ZrCUYt7Dpr8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=EbE4Om3VpGQcpcAqifKmMhN+gaoe7oebZybS03/v+x1OUNZhc5IbGhXEwIIBWk+gOPhcq+PVEAqtjfRK7tY89OKqbAezIN/pjExNYAuUQGmCR91cHqfB0a8ssugFq4uwAdR/1ku5m3m0859iFWd1V2ZxTpyctNdAmFE1/ULYl3ouAbgqIs9zfbjP1xovt7Ucgp++Eh6hszLKfNSjLaTRodvTtyxTNbHwaYDPhAt4ed2EpeiMFzTEG0LnjbBeIc/2VhqnJZ8GU2kQQNzM+OHU14luQynzKCJnKRLn1pNUMcpuOFEAwgRqSBp+aCnKzOmrsGa1jLS5owUX5EfA/FZcFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNSwH1wNLz2xSS
	for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Nov 2026 22:58:06 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 9 Nov
 2026 19:57:48 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 9 Nov 2026 19:57:48 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 9 Nov 2026 19:57:44 +0800
Subject: [PATCH] PCI: aspeed: Drop PROBE_PREFER_ASYNCHRONOUS to fix
 enumeration race
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261109-aspeed-pcie-sync-probe-v1-1-71cc9e718623@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIADe18WoC/x3MQQqAIBBG4avErBvIgsCuEi1Mf2s2Jg5EEd09a
 fkt3ntIUQRKU/NQwSkqR6owbUN+d2kDS6imvutHYzrLTjMQOHsB650853Ks4OhMsCPWwcNSjXN
 BlOsfz8v7fi+WRZZoAAAA
X-Change-ID: 20261109-aspeed-pcie-sync-probe-fa1d96eb3ce9
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan
 Sadhasivam" <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, "Billy
 Tsai" <billy_tsai@aspeedtech.com>
CC: <linux-aspeed@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Jacky Chou" <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794225468; l=1635;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=s6Law+1V/WSTB0M0wQ+df/1sBAiY3koHL3kisdnpil8=;
 b=LUMFJRsfpnYqDcQzTsKxiRuUo3UGu9RdRs4M0DD8r19Mo94UXrSlUGkK4aZ/qKCDzkk8T4S2+
 QRj93BW4SwtADPkEpcmNMfvJwqPuLiA0vtNXhKM0+cEhtqH8E2JXCYn
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ASPEED PCIe RC driver opts in to asynchronous probing via
PROBE_PREFER_ASYNCHRONOUS. This allows the driver core to probe it
on a kthread in parallel with other drivers instead of waiting for
it to finish during the synchronous probe pass.

On boards where a PCIe endpoint driver is bound early (e.g. built
into the kernel or probed from an initcall that runs before late_
initcall), this races against the RC driver: the EP driver can start
probing before the RC driver has finished enumerating the bus, so the
EP device is not yet present and the EP driver fails to bind.

Remove PROBE_PREFER_ASYNCHRONOUS so the RC driver probes
synchronously again, guaranteeing that bus enumeration completes
before any downstream EP driver's probe() runs.

Fixes: 9aa0cb68fcc1 ("PCI: aspeed: Add ASPEED PCIe RC driver")
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/pci/controller/pcie-aspeed.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-aspeed.c b/drivers/pci/controller/pcie-aspeed.c
index ecb7562f84c0..def5591010ca 100644
--- a/drivers/pci/controller/pcie-aspeed.c
+++ b/drivers/pci/controller/pcie-aspeed.c
@@ -1104,7 +1104,6 @@ static struct platform_driver aspeed_pcie_driver = {
 		.name = "aspeed-pcie",
 		.of_match_table = aspeed_pcie_of_match,
 		.suppress_bind_attrs = true,
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = aspeed_pcie_probe,
 };

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261109-aspeed-pcie-sync-probe-fa1d96eb3ce9

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>


