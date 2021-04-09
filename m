From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 09 Apr 2021 15:03:10 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v2_17/21]_dt-bindings:_ipmi:_Convert_ASPEED_KCS_bin?=
 =?UTF-8?Q?ding_to_schema?=
In-Reply-To: <YG/i9lSxxCMIzkRs@packtop>
References: <20210319062752.145730-1-andrew@aj.id.au>
 <20210319062752.145730-17-andrew@aj.id.au> <YG/i9lSxxCMIzkRs@packtop>
Message-ID: <29937129-3a17-4a32-a723-191b693a1e0c@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 9 Apr 2021, at 14:45, Zev Weiss wrote:
> On Fri, Mar 19, 2021 at 01:27:48AM CDT, Andrew Jeffery wrote:
> >Given the deprecated binding, improve the ability to detect issues in
> >the platform devicetrees. Further, a subsequent patch will introduce a
> >new interrupts property for specifying SerIRQ behaviour, so convert
> >before we do any further additions.
> >
> >Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> >---
> > .../bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml | 92 +++++++++++++++++++
> > .../bindings/ipmi/aspeed-kcs-bmc.txt          | 33 -------
> > 2 files changed, 92 insertions(+), 33 deletions(-)
> > create mode 100644 Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
> > delete mode 100644 Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt
> >
> >diff --git a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
> >new file mode 100644
> >index 000000000000..697ca575454f
> >--- /dev/null
> >+++ b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
> >@@ -0,0 +1,92 @@
> >+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >+%YAML 1.2
> >+---
> >+$id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml
> >+$schema: http://devicetree.org/meta-schemas/core.yaml
> >+
> >+title: ASPEED BMC KCS Devices
> >+
> >+maintainers:
> >+  - Andrew Jeffery <andrew@aj.id.au>
> >+
> >+description: |
> >+  The Aspeed BMC SoCs typically use the Keyboard-Controller-Style (KCS)
> >+  interfaces on the LPC bus for in-band IPMI communication with their host.
> >+
> >+properties:
> >+  compatible:
> >+    oneOf:
> >+      - description: Channel ID derived from reg
> >+        items:
> >+          enum:
> >+            - aspeed,ast2400-kcs-bmc-v2
> >+            - aspeed,ast2500-kcs-bmc-v2
> >+            - aspeed,ast2600-kcs-bmc
> 
> Should this have a "-v2" suffix?

Well, that was kind of a matter of perspective. The 2600 compatible was 
added after we'd done the v2 of the binding for the 2400 and 2500 so it 
never needed correcting. But it is a case of "don't use the deprecated 
properties with the 2600 compatible".

I don't think a change is necessary?

Cheers,

Andrew
