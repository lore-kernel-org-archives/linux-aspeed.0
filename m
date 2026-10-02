Return-Path: <linux-aspeed+bounces-5116-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425EBCA5FDD
	for <linux-aspeed@archiver.kernel.org>; Fri,  2 Oct 2026 23:56:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxQg112lTz30B0;
	Sat, 03 Oct 2026 09:56:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790955461;
	cv=none; b=bSd4d3SWc4w4OkxnQYeA0Xi/636df16Kw4EhidAtDQVSxVOTdSYxv8PEhXA9fG+R9YMRhEl5tzvrmFzPPP3OATka0EsDTiZXK4+/Fa/3H0mcnPsq+7VFz4RTexXitGdve1fE5neYFIgxd9TetAi8VA4pRcJRvwr1eqZKN47R4/TJg5zU81TU9F/9b/7DTAH5jL/8Tq2t+NBZTVmNJGwtT/nplRwyUTZ+oplAcbJO7plMj1WEXKYIEjaG0Vhh1EXdp3HxNBrFVsQ0qbHQKI1+2Ncz1L05WSE8Dl5spo2o9KIyt5IfZPsCH4wAP6iDlLjiuYiPmipffrZEPKmG/8aNQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790955461; c=relaxed/relaxed;
	bh=ijByx0+/K4d2ninXLykZb17+oCSqxaAY4HTB4azbBqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6eylfxM7PECvvHNDFKKAALXEcKTj4auNuYjFfUqsDLBvWENaMf5J52sPOYcHIiClfcrWV3JYY0qnDiWKhcQkuI8sdXo+KBX4T1KEd7Lbtb6KtXSSrJHvX9n+tpMKHiUhjXiOFu7wu0IC7/IBhqrxZEEjQHOVBxczRmacRNuFtIlwOoVUXDLhG9oo9RzjAmHO/tFUPtlo0/wTg9lHROKgNUPzibYbMa1TldybmuM/U8HYImA+iw7E/S4M7J1Fdc9a037iM7YsWzrlDR5heREb5emCojzBCgCGZTfPWhv9Md9WyZUiFMQYTB1u/dpNJ2od2vniGJNGoskpMQuM30xYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iEDagicz; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iEDagicz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxCb90tgZz2xLg
	for <linux-aspeed@lists.ozlabs.org>; Sat, 03 Oct 2026 01:37:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790955461; x=1822491461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k7Lyc4eyl86PbGTSOmv7ydB0HYVEW7WA0vnMeArh/5E=;
  b=iEDagiczgVbco/VsjCguL4/HV3JgpxJAn23KNjq6KP+g8s1d6SX9Yedf
   iM8rL67Vy5jQgCjt1RN/meJ3VPw4N5bsB9uvCM12BIwzzLrz/uQrAsBst
   FpCHYvp3EuktVscMxYpxgi3cww01DLhfDZYqi1FUa6MiZlaxzErJu9XaI
   9OrTDDss4VWsWABp8FS6vuAOE1kW7lsVCsPvaBpzf/eP9Io4SAktiB3ow
   TZYzd7q2q+eI13Y0CbSHCGaaqI/P8gt9fiWGysn7NwWyTCOPXgtaewPGL
   pR33+ZQ1+RjgkUcZlpLMh3ara/oE0h/VsYy+9Qn+4xVNPWzO4Rv8kBsm6
   Q==;
X-CSE-ConnectionGUID: 9vTtoFwkRfmHPvFrK9k6mQ==
X-CSE-MsgGUID: qt4aDIlLTyKNEdmE4BoLZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="117247714"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="117247714"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 08:36:39 -0700
X-CSE-ConnectionGUID: V22czOdbTVWeMqrDTzxWAA==
X-CSE-MsgGUID: 3X18j7onTsqwz70mkBfEfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="279522397"
Received: from gklab-103a-129.igk.intel.com ([10.91.103.129])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 08:36:36 -0700
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
Subject: [PATCH 2/4] dt-bindings: arm: aspeed: Add Intel JNCRP board
Date: Fri,  2 Oct 2026 18:32:43 +0200
Message-ID: <212171467173c9af64b3f8ecddca2a445b7e7148.1790344811.git.dawid.glazik@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790344811.git.dawid.glazik@linux.intel.com>
References: <cover.1790344811.git.dawid.glazik@linux.intel.com>
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

Add a compatible string for Intel JNCRP BMC board.

Signed-off-by: Dawid Glazik <dawid.glazik@linux.intel.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 2c8180e49b2f..6f7d77efb30c 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -107,6 +107,7 @@ properties:
               - ibm,sbp1-bmc
               - ibm,system1-bmc
               - intel,avcrp-bmc
+              - intel,jncrp-bmc
               - ibm,tacoma-bmc
               - inventec,starscream-bmc
               - inventec,transformer-bmc
-- 
2.43.0


