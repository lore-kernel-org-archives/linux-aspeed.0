Return-Path: <linux-aspeed+bounces-5171-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87120CA9ED0
	for <linux-aspeed@archiver.kernel.org>; Mon, 12 Oct 2026 16:44:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3Nc04rBTz3bp7;
	Tue, 13 Oct 2026 03:44:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791823488;
	cv=none; b=bP0c6A8UsMwclxhRucGnhdHK+R09U5iL1MaFvGdV5JXEhNfHQwq19mAtO+OU6/DLDmhn5IlcCg6RGWsnwjQuZ6mllhngKdLmmhldeBlVpHKhwzJs8IEIOm3dfI3lFzUvmK1F/uf/JwaSb5Nm8JSWR3vrJeaYHb5nYuGn/mVuXy1+Oxce/ODsGb+QLrHMILuFCF4zuHnhGeGwYGgmQFIly59eqLlPQrUxMyzBUz3qAgwLsF8fLOre1VYCKg6snpg3+NnAvVtEu17iuG3M3ULzCte8uI71j7W7z6PK/+u2jz/ZNBmR484M0CA1TDFmG+Nc+QIQ2GxOtiNwFTBHxr3/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791823488; c=relaxed/relaxed;
	bh=jCEnnIXq+wscEvAbwOlCsu2gpg65/OuZHD1QbNIMziw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBcGOMkMs0LXC0Qow/c5Bcd1Ylqz65EydBTTU1i7xigancWtckYdnGzUd6UoGr1bkFBq/2fgH/UQPu1FmnssFmhbZ9OyA8nvC3RdPx/4u2uLD8s2bl2jlhwkydHuMfwr/0Dntk1y9QheAWan2fxyEYZBcGibgq7YAwvEvy3Xt9xSwP18Q6YzfkfwCw6oGLymOQGWXR2oU9X7PYB7dLz/EL9yhiq82CHbP6VyaDQzath5AzX0uZAa3rMi+5qwBpO+e/0Nj8ED7r+2wCK9hH8VeGDttzt3sJ7fQS9e90l0VXaV7Y7T6j++wtbgEIQiGqjP2LS80c5AmLY+VNzfONeY4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MtdHW8Fk; dkim-atps=neutral; spf=pass (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MtdHW8Fk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3Nbz6Jf2z3bNr
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 Oct 2026 03:44:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791823488; x=1823359488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qp8ehQlKBEpYMpNpbGBobCp0JbCv+zToa4qq8WFMcAk=;
  b=MtdHW8FkVp2JOfiQogOtrpIn7fPlviqOBBYZW7kL6kBy97gwZKlYTlnv
   0/CixBxyHOoYP6Z6+ga79TUt63rEvKPD5UpKNtOnbsyGCvLLYdBg7JHMF
   DMHgvL88yeqSNPytIk9RBPblc6dkRtChNHp9v/9tzmpn3l6/maG/afshp
   +t68c187YM+DcaYSDP4QJEhVrUjk3Ms4ArlqwWlkI+9/a3JrDtOKPeakS
   r28vSWBvntJ47cOwASh9psaTIFuI2im2C5MQgC8oaDKc8F0oWYFJ052So
   ymdRPTJ3L5NdqhPQ9ZQGOXTxc858Sb/DBKZxPGiZLjj9V8ztxcR6MVFht
   w==;
X-CSE-ConnectionGUID: YV6CG1UFTryrE70cAmIPLA==
X-CSE-MsgGUID: 0ElJFA5JSBWnidOED4hSXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="410085"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="410085"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 09:43:43 -0700
X-CSE-ConnectionGUID: asXuhYDSTKqumKcmgKmFqQ==
X-CSE-MsgGUID: 35YRVcKoQ7yCpmP4X9cXyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1004936"
Received: from gklab-103a-129.igk.intel.com ([10.91.103.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 09:43:42 -0700
From: Dawid Glazik <dawid.glazik@linux.intel.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	dawid.glazik@linux.intel.com,
	maciej.lawniczak@intel.com
Subject: [PATCH v2 1/3] dt-bindings: arm: aspeed: Add Intel AVCRP and JNCRP boards
Date: Mon, 12 Oct 2026 19:39:05 +0200
Message-ID: <0b8fbf07323894a48a777ea531713a0285e319d4.1791825961.git.dawid.glazik@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791825961.git.dawid.glazik@linux.intel.com>
References: <cover.1791825961.git.dawid.glazik@linux.intel.com>
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
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

Add compatible strings for the Intel AVCRP and JNCRP BMC boards.

Signed-off-by: Dawid Glazik <dawid.glazik@linux.intel.com>
---
v2:
 - Squash the separate AVCRP and JNCRP commits from v1 into a single
   commit, since the changes are small and closely related
 - Fix compatible string ordering so the new entries stay in
   alphabetical order within the enum
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 8ec7a3e74a21..60e8e73da3f5 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -107,6 +107,8 @@ properties:
               - ibm,sbp1-bmc
               - ibm,system1-bmc
               - ibm,tacoma-bmc
+              - intel,avcrp-bmc
+              - intel,jncrp-bmc
               - inventec,starscream-bmc
               - inventec,transformer-bmc
               - jabil,rbp-bmc
-- 
2.43.0


