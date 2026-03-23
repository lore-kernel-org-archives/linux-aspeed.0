Return-Path: <linux-aspeed+bounces-3758-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75688FEC11D
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Mar 2026 22:51:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgQJR0lLDz2yng;
	Wed, 25 Mar 2026 09:51:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::c32"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774281682;
	cv=none; b=aEwwb2Hmnyx2IfpQkW/aXsGbB/fRqvYQLoi+RsW++w8Iwg+voLJ7t0nb4OhT5u/7Qy3wK9UJ/MduUszSp/DdZ9zhgX5BlqDScf8CncUpT5lgVC14EoZFB2zgnKtGYctOSS1t8g2qvUTkPrOSe2DdKrnNBUMyknoq17UdVZ85vMNPbJqxKmUjehrd7YawgS6ggW73NnBCITBEfAvV425AAypwP47eO2jyiflcIg+gPCgJYK3xPFAPV6A/J7gXTbronm6NecDfQ4W0C1kgb/NOShTFWcnJi2JHCwuvI9lleXS5U+6u694dzmOqnClr3OjCbvNeneyQ45RoRiEdk9QbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774281682; c=relaxed/relaxed;
	bh=mObnim+O/1qM5mBF9TW6/nMqNmbffOtpWCv4mCo57ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9pC3xNWnkNJdiyo0/WRtFxOA0ddVNmwkmN374EBtpVf57sj3QwzOdXcz3PU+fsBOSoCh3iBroRHSyYKpUebY73fJT/MgnxI2ESrz6lqZFti4BMjuvs4ZKMdTuvmzEfFT+snTi8FAQjR4E2awMLEh2VCeoVX9gO377oYd7c6MNf6OA3tTHf7VpfhfgyeWxxhLc3aAq/wwK66GbPpN5a/CfiZqpbWS3/Gx4/FQ8/TgWGDRWoEha26QW1V5VWbdtdS62p14NoMA7/CFYOTTLBAcLintS6kEp6x0HMnSKOiwuRwde3PHrEDf14fv4nBR2GK7tqxVNKZIjdlIT/WivNDzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.a=rsa-sha256 header.s=google header.b=FGCw31bT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com; envelope-from=vineeth@bitbyteword.org; receiver=lists.ozlabs.org) smtp.mailfrom=bitbyteword.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.a=rsa-sha256 header.s=google header.b=FGCw31bT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bitbyteword.org (client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com; envelope-from=vineeth@bitbyteword.org; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffdFZ0gGLz2xlh
	for <linux-aspeed@lists.ozlabs.org>; Tue, 24 Mar 2026 03:01:22 +1100 (AEDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-67baf20e8c2so1132315eaf.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Mar 2026 09:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281680; x=1774886480; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mObnim+O/1qM5mBF9TW6/nMqNmbffOtpWCv4mCo57ds=;
        b=FGCw31bT7oytgJBDTyTXWFGn3GZBpfHVj8f6umTJbYO0h/IIFbudfhfD+Tpjcoc/md
         nv7ZW2Gat+68nYf9Xi2pWJTqbhm2q5oqnLffeBFKVD+CM3Q28N7Xw4Oa8uKrPr4vJZIN
         ZTMBj1TKVKujNtVjSDkZa/p6M7Z4w30WWE+mZ4X1sQbzjZ/FvefBlV2Kz1/HJgbCk1fk
         v9AVhX0rQMK69kFVU7dkBFI6KEzRrUjoBtl/lgVqXrB/YXP7OD/xDFFGFEKWM8ZQM2Bx
         4dHMCwlDoqkI6Aoo+GSrxu+lj5nzoYx2LmWfSTyd3g68SQGpJyEttN1PxtdQtO1866+W
         GokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281680; x=1774886480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mObnim+O/1qM5mBF9TW6/nMqNmbffOtpWCv4mCo57ds=;
        b=CdS5z0V4fqmA37Ja+Y39YljFDJtx5MafCf5/aA3HCHwPdLTjmMHmLpf//h6hjCUfxQ
         C0c8RAsUonJ3Pvnw4mcOfE4kwuouS9VABeY0VX8kyWlJDltDDDylkFJXzQDRxXaisMQb
         1FimuFnLt1QO2n7ea1lmgjETIBHBRq0txcM/JHLWHBexAhMFWwdJtAsR/9eDDTygorlH
         HvW9IYqLo9yw3JbxrkVjs+PQA6JPMTTr5KPuCJRJncV31rdnPzHfOMi4P0tAqs2wdruL
         dPW8iD9voZLwZs2dCpwbQB2NwUZKESy+tFVJqPEpcGeNW/SldkC5D6XSwvie8ajJvVMG
         jiZA==
X-Forwarded-Encrypted: i=1; AJvYcCXpIl4WK9POLO1MTLTCpxW/WsE7q+yZUgiu0Nk9WZ8Al79yhVNyd6wqUiZkII/aZd21ppfT8MUx6u2i3Mw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxuc5eZksgwi0/SX8YBbA/DswRyAk8qI1uU5u+s12ilkFhO3D0a
	1QAfYxpt4dkjcEVIsAXYHboC8V0rxWmsb/YmKn3q0s1ZGzerOKuRgJeKaKsIa1mH7xM=
X-Gm-Gg: ATEYQzzwFGo6lDYmhjvUM5SuXzFPrafwbue36z1S3oe16NFszpFdyEkVqo3HU2XR9e9
	GAdFQIok+JmTOqFiVJZ/kvt+YJbn+bmLXopEYNvQ7pyRkNnPIPtKv/hY66/QbkHXpGF8vtMkPVp
	QoURk8FlAAUzXA8OQrUbz7S+iP2tWa9I4tVSopLxSsvql8u9McT6J3OiNHHh8WY6im55+ZF6cNH
	38VH9Fuzls8QzSZRyuDEU8u18UHFNOCGHGQz6KwD296bfkFj/P8+yijOGcoIhyD+VnldFQ+QpEc
	9zlvCCy0EMq7cptrRkWA/DxUmUD8Ge8fhmQOzPZ9RaXd3llJ0omq/P83xZBVrkrSW1zN1OYyH80
	7Jj35pDZ6qgOUWsKTATRvZy1LCSIgAMsPOjTZmQTtIUkyGo+wl5UBqB2AADDaRLVC0zPgmeI91i
	snLJHOkw3BLq4FrUlZLL1rxjDr46o98qaFGJYEHrrt8DL7RWgSL4bRlfuVrfoWU6ij2A==
X-Received: by 2002:a05:6820:987:b0:67d:ee07:32df with SMTP id 006d021491bc7-67dee0735f2mr1955626eaf.23.1774281680005;
        Mon, 23 Mar 2026 09:01:20 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:19 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Eddie James <eajames@linux.ibm.com>,
	Ninad Palsule <ninad@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-fsi@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 09/19] fsi: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:28 -0400
Message-ID: <20260323160052.17528-10-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
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

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/fsi/fsi-master-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index aa1380cdff338..8313c7d530eb7 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -229,7 +229,7 @@ static int check_errors(struct fsi_master_aspeed *aspeed, int err)
 		opb_readl(aspeed, ctrl_base + FSI_MSTAP0, &mstap0);
 		opb_readl(aspeed, ctrl_base + FSI_MESRB0, &mesrb0);
 
-		trace_fsi_master_aspeed_opb_error(
+		trace_call__fsi_master_aspeed_opb_error(
 				be32_to_cpu(mresp0),
 				be32_to_cpu(mstap0),
 				be32_to_cpu(mesrb0));
-- 
2.53.0


