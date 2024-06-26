From: Paraskevas Nik <parisnikf@gmail.com>
Date: Wed, 26 Jun 2024 09:09:49 -0000
Subject: Aspeed XDMA Controller and KVM
Message-ID: <CAPPt5JbFkMxO5aSE2C2LhhOY7oaO=dwydYMDrMsoMo-+mvNrkQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,
I have enabled XDMA Controller on Aspeed AST2600 and I have also reserved a
memory region.The driver comes up as expected and DMA operations work.But
KVM becomes completely unresponsive and not working.Also the Aspeed VGA PCI
Device has Unassigned Class as it can be seen from the lspci output in the
file attached.

My question is if it is possible for the XDMA to work alongside with the
KVM.
KVM stops working only after I have enabled XDMA and restart the
HOST.Please have in mind that the XDMA reserved region does not overlap
KVM's (Video memory region).

Thanks
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240626/3b5cf156/attachment-0001.htm>
-------------- next part --------------
03:01.0 Unassigned class [ff00]: ASPEED Technology, Inc. Device 2402 (rev 01)
        Subsystem: ASPEED Technology, Inc. Device 2402
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 255
        Region 0: Memory at 42440000 (32-bit, non-prefetchable) [disabled] [size=4K]
        Region 1: Memory@42400000 (32-bit, non-prefetchable) [disabled] [size=256K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
