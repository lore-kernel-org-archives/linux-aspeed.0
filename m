Return-Path: <linux-aspeed+bounces-3933-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F309EF588C3
	for <linux-aspeed@archiver.kernel.org>; Mon, 20 Apr 2026 13:31:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fzmbQ4kDdz2ynn;
	Mon, 20 Apr 2026 23:31:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776691874;
	cv=none; b=JHnHepAz659+ROdGmNBBZU9Spa0jbGF0hpUB+75wfdOoIrKRZppvRwfVXH1b+BG6E0rls9/CoTCwiIDJwsPq7+aMHrWhHxfB8pLj6d6wTky5w65oi3ok1IW8sEtWwN744cSRhd5hpnZ+5duHde/zp3t5gQQX/HGMvjUaz8Zqy5MdcDOAqAm3DuIJJCqEzlarElk8NtkZIHNmehw0JWkioIB1jWHXAUZ8Icl5s/QAJC3YsKDzQ+ryu/6Iv5M6HP8yhTWo637UPwKzZQalkmqYqoGE856ZfHIm90Xz+c9QztRaBrfusLk8J2EbMzMHVyJAeasyV3gL5p9ui0VFu2YQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776691874; c=relaxed/relaxed;
	bh=HJjRxqIoxs+kFoW+rgn321zUfOfzgUlKpWyHQaUD7Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTer8RGngRlXexAJzpDr8h67TfhV5CNu25R3ABvHpmvtqdk1PB5ZM0t4PzdMP3Lftzv4NXxWuU7wOWg0YM8lpeOOlJx8spe3KrxG098w8c8ZaM/XHmxGI0YbyeAZtlTcjPCSI9KNyLIgmRnZhseCeNgwLISvSZGwPrlHVW9U/ICfICLwXql7UA6k2SwUXCpxTDZ0swAnqXkJ/qMcRjoPr+Qlz6u3Rx8H4/V59o2BaSvMUHIonCdmos7VL3DjCIxdDZMTDGz8DdKkrne8WN44eySegDR9bxzLrXvdAr3NwxqZdHMJnHjNShlyOMl3YmvraJwI85SoveER9CzgtLGV3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o3vPibwK; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o3vPibwK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fzmbQ0FyMz2xll
	for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Apr 2026 23:31:14 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 432E06014C;
	Mon, 20 Apr 2026 13:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12357C19425;
	Mon, 20 Apr 2026 13:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691871;
	bh=WndapDrQTW1NPt1zLNN45ytCLcjeyhPdv7mnUOJLjQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o3vPibwKbJukBRKRnMELsjExQgK+Yp2oYTSMYJavReabOtMBoRuAuQidpnkzDtmpO
	 LDAUbsPIJZ+OV6CdkqZ5ozCyD8YQXpZL0moRo1DLMI8+7qExzUlTrK86eZBOHu0DbT
	 BDLn8i3Z7IxA8yTgh8J1Vx3yE0Bygqjkarnd6N0fbCWXgm8ee47kUSZq8Np3xBS2hb
	 PfScoF69hB6QDTZgnOCqdxto1e96IjG7mPy+/ZUiahNumxXLMSSqQHQe3r6ELTekNT
	 e5YS2iIZWqjWoNkPc54GU7ukMvmmRMijqkd/dfx4Sf5AqCt/B7Z55yFofh8C0jgqZm
	 trhSlfPCJNPWQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Potin Lai <potin.lai.pt@gmail.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Sasha Levin <sashal@kernel.org>,
	joel@jms.id.au,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] soc: aspeed: socinfo: Mask table entries for accurate SoC ID matching
Date: Mon, 20 Apr 2026 09:20:37 -0400
Message-ID: <20260420132314.1023554-243-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
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
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit

From: Potin Lai <potin.lai.pt@gmail.com>

[ Upstream commit 7ec1bd3d9be671d04325b9e06149b8813f6a4836 ]

The siliconid_to_name() function currently masks the input silicon ID
with 0xff00ffff, but compares it against unmasked table entries. This
causes matching to fail if the table entries contain non-zero values in
the bits covered by the mask (bits 16-23).

Update the logic to apply the 0xff00ffff mask to the table entries
during comparison. This ensures that only the relevant model and
revision bits are considered, providing a consistent match across
different manufacturing batches.

[arj: Add Fixes: tag, fix 'soninfo' typo, clarify function reference]

Fixes: e0218dca5787 ("soc: aspeed: Add soc info driver")
Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
Link: https://patch.msgid.link/20260122-soc_aspeed_name_fix-v1-1-33a847f2581c@gmail.com
Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 drivers/soc/aspeed/aspeed-socinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/aspeed/aspeed-socinfo.c b/drivers/soc/aspeed/aspeed-socinfo.c
index 67e9ac3d08ecc..a90b100f4d101 100644
--- a/drivers/soc/aspeed/aspeed-socinfo.c
+++ b/drivers/soc/aspeed/aspeed-socinfo.c
@@ -39,7 +39,7 @@ static const char *siliconid_to_name(u32 siliconid)
 	unsigned int i;
 
 	for (i = 0 ; i < ARRAY_SIZE(rev_table) ; ++i) {
-		if (rev_table[i].id == id)
+		if ((rev_table[i].id & 0xff00ffff) == id)
 			return rev_table[i].name;
 	}
 
-- 
2.53.0


