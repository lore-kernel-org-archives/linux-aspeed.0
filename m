Return-Path: <linux-aspeed+bounces-3873-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B658910FC456
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Apr 2026 22:54:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frdgL3DJmz2xjQ;
	Thu, 09 Apr 2026 08:54:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775677332;
	cv=none; b=gx6OYHhVk3XqnVDJKg9gN5UaNCikk8kV0GwXIq9yMUDTKFjmddV9fSaa4GTiHCUuusRjC21fIgGVft84Wy07skRgwlLh3S/flSlITsGQKxZvRjsuMimSV1RvR+fzCkYL/S21h1aODJjWLgT/a3yDjpk3KW+Lu1w6+Z222MvbX9Z8wa5LnS8prir1NX7gkOBaiAsyV+BaTZiQwPZcuKxjm4ZeHt+1Y3L/KR17JWTapLRlz8LTYWX0bA0q6Aiy8uk1Cgx0qVKdpIcPLTkUyzsY7u67GRK16hr8veusHKariIr3LbB8AsLCZ3Nb/f4GKxboVCUwU21euX7/C4H4eXMu1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775677332; c=relaxed/relaxed;
	bh=eOJEsvDTW4Ey/lUSDp0kL7esO3ZCACa219SbXwsk7Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q//H7GWD3fvPsnyHdp3B0fzHvA21/g+Y1NNMPnQe8dIbrudTFF2yHSA7/BJMD9mOrk0Qds2E1yJ089LWcPwsEO7vji7sNBQhHY7zQHFCLZamoTD7Eopd2mbxYdS6K+bpjNXDo7AYQQ+CUTeHy6il9inm0BZrtU/wgFX03TK3xPt/mnJO+n5qxLbwoRvQrayN4a0dWACfQWSMMheHeglq/1NWmL7KtulOKsmn/1vuwYPRGo5Z4POaNci0MTaYcIURwrEZqoZYtpBpmXEjW+a8hyexl1U3DE7a7OFZVnbt8HRFZ3kSq2DdmUXuE1ilCLqws3QoAJTtijnNexWwnMPJvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AIHNVI3N; dkim-atps=neutral; spf=pass (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AIHNVI3N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frYNz1wTyz2yC9
	for <linux-aspeed@lists.ozlabs.org>; Thu, 09 Apr 2026 05:42:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775677332; x=1807213332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JswzvqIUM/Y0snFlKb+yBLx2iydNCgWMkhaiYqyvcrU=;
  b=AIHNVI3NJjgawVk5GFVY/JBn5YVxEk11tVWcPumobZQSbCsK4wHkTJU9
   8WjDnRMVREELr8VIcjq4+aqE6vDtZwLuxLCUX+Lg4rL6XprCKjNQoEWu+
   OAkfXUl92MXtEJPuPgWetIPE6BwrmbiY3MeVodfywSjBJOPAWYuKq5uzr
   dy4NLt8p9+COq6T6feLvcMXq9s/azptEntpFmD0SZ5qKDjAdtXgrcgE/J
   L1LE2Ju6OMNOM3vAq5xXEeDenGkZArGjM50ujQfv0ZKYmVdLRf0oD6G7h
   2IiHzrfqeiKBGgfaOWT2W5eddlmLBDPY4Quj5I+IzhI4zJbk++ZP5zR0M
   g==;
X-CSE-ConnectionGUID: PuaVttiMS1OiQG/OKAYTiQ==
X-CSE-MsgGUID: FWA17Gb4Rii3HsS+Q8JjGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="88056924"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="88056924"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 12:42:11 -0700
X-CSE-ConnectionGUID: fU2drvZHTDqcQFHupFc6zg==
X-CSE-MsgGUID: ecX8swQCSCSeREGdg7ZbOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="222053381"
Received: from gklab-103a-129.igk.intel.com ([10.91.103.129])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 12:42:07 -0700
From: Dawid Glazik <dawid.glazik@linux.intel.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-aspeed@lists.ozlabs.org
Cc: linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Frank Li <Frank.Li@nxp.com>,
	Dawid Glazik <dawid.glazik@linux.intel.com>,
	Maciej Lawniczak <maciej.lawniczak@intel.com>
Subject: [PATCH v3 3/3] dt-bindings: i3c: Add AST2600 I3C global registers
Date: Wed,  8 Apr 2026 22:34:35 +0200
Message-ID: <7f55458097ef651b4fc46650254afd3fa7b87348.1775679285.git.dawid.glazik@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775679285.git.dawid.glazik@linux.intel.com>
References: <cover.1775679285.git.dawid.glazik@linux.intel.com>
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

Introduce the device-tree bindings for I3C global registers found on
AST2600 SoCs.

Signed-off-by: Dawid Glazik <dawid.glazik@linux.intel.com>
---
I wasn't sure if I should add newline at the end of the
file or not so I took
https://github.com/torvalds/linux/tree/master/Documentation/devicetree/bindings/i3c
as an example.
---
 .../i3c/aspeed,ast2600-i3c-global.yaml        | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c-global.yaml

diff --git a/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c-global.yaml b/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c-global.yaml
new file mode 100644
index 000000000000..edecc18796a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c-global.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i3c/aspeed,ast2600-i3c-global.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED AST2600 I3C Global Registers
+
+description: |
+  The AST2600 SoC provides a shared I3C global register block used by all
+  I3C controller instances. This block contains per-instance global
+  configuration fields, including controller instance ID and SDA pull-up
+  configuration.
+  Each I3C controller references this syscon node through the
+  aspeed,global-regs property.
+
+maintainers:
+  - Dawid Glazik <dawid.glazik@linux.intel.com>
+
+allOf:
+  - $ref: /schemas/mfd/syscon-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: aspeed,ast2600-i3c-global
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    bus@1e7a0000 {
+        compatible = "simple-bus";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0x1e7a0000 0x8000>;
+
+        i3c-global@0 {
+            compatible = "aspeed,ast2600-i3c-global", "syscon";
+            reg = <0x0 0x1000>;
+            resets = <&syscon ASPEED_RESET_I3C_DMA>;
+        };
+    };
+...
\ No newline at end of file
-- 
2.43.0


