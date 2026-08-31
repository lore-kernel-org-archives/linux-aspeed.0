Return-Path: <linux-aspeed+bounces-4886-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44FEC61DFD
	for <linux-aspeed@archiver.kernel.org>; Mon, 31 Aug 2026 23:57:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYmBj0DgQz2y2h;
	Tue, 01 Sep 2026 09:57:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788182346;
	cv=none; b=EQthC/TYdplnASqFOYqhHdSawiH12WPs3LROTqDudaGadascga631Z6H6PzBr4Gxnvb87JNGX6RuBl906/04qzoOvr/KfHmkCp6iRjGK6mDUJfqydJElfXjWZZbzIVbiAezla/FjQKjP+maty6/f1zfd3TxOGEgXeM6J+pO1NC4sKSbcfq8LaXmdZ7xNXBAYhgP2msN7okqhFNJelF7u6QtH6LEjk9JLofauOqnNtk7nd3B3qYE4vmZjSSA9jhRh/nJNw4f5VOsMSxy8moBRa2xxsI/hfwFiNacO9hbAqxE0mHFIucJcaTDLsByRkpoNkbLGhf9S2MuaRG+UyiOxvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788182346; c=relaxed/relaxed;
	bh=P5ZhixbZZK68XnYWmJJNtDj0oXYUmqsiL6CAlg4bVCM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jOWKzytOc0cGBik5P1NA0BKB9b35W2O6KjMiMvEiZ0T0Mo+l2nG1fK2po9Bc1Khn8XimV65OwkOzBLM+96x9Ftzn57sFCPS/U/kJQiveRxL9Cq/SagijiaDtz58ksbaNWMhRAGI3pyMwiD7sbg3J1PcTnYLfHH94kZ0T3kW29232sgwGaXK9qTjl4D5/8UD/CBZY2fkTNyLlJI1mzYEo9XDeY5PNxf6FCyiX44aKq9Q8BVEoP7eI9u9M+tOjvsnV3VhIuUkJCDTLMrIYpf9oUYutx+ckXQgNrsViKdF4hJqWJBXQGdT+JdZ5/aOut9xPro6jYFm9rdJ6qunySe9z6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=fc1m=gy=oss.qualcomm.com=manivannan.sadhasivam@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=fc1m=gy=oss.qualcomm.com=manivannan.sadhasivam@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYV202Qcyz2xpn
	for <linux-aspeed@lists.ozlabs.org>; Mon, 31 Aug 2026 23:19:04 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C4A2B6022C;
	Mon, 31 Aug 2026 13:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECAC1F00A3D;
	Mon, 31 Aug 2026 13:18:56 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: linux-pci@vger.kernel.org, Liu Zhenlong <dragonliu2018@gmail.com>
Cc: jacky_chou@aspeedtech.com, mani@kernel.org, bhelgaas@google.com, 
 lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260816171633.15025-1-dragonliu2018@gmail.com>
References: <20260816171633.15025-1-dragonliu2018@gmail.com>
Subject: Re: [PATCH] PCI: aspeed: fix clk and phy leak in
 aspeed_pcie_port_init error paths
Message-Id: <178818233640.33196.12707078026403586187.b4-ty@b4>
Date: Mon, 31 Aug 2026 15:18:56 +0200
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
X-Mailer: b4 0.15.2


On Mon, 17 Aug 2026 01:16:33 +0800, Liu Zhenlong wrote:
> aspeed_pcie_port_init() calls clk_prepare_enable() to enable the port
> clock, but if phy_init() or phy_set_mode_ext() fails afterwards, the
> function returns without calling clk_disable_unprepare(), leaking the
> clock reference on every probe failure.  Additionally, when
> phy_set_mode_ext() fails, phy_init() has already succeeded, so
> phy_exit() is also missing, leaking the phy reference.
> 
> [...]

Applied, thanks!

[1/1] PCI: aspeed: fix clk and phy leak in aspeed_pcie_port_init error paths
      commit: 6c566177fc8f728271bed8018ac77b0a8199200d

Best regards,
-- 
மணிவண்ணன் சதாசிவம்



